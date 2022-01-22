import 'package:flutter/material.dart';
import 'package:flutter_fetcher_state/src/models/mutation_notifier/mutation_notifier.dart';
import 'package:flutter_fetcher_state/src/models/mutation_status_notifier/mutation_status_notifier.dart';

typedef MutationCallback<T> = Future<T> Function(BuildContext);

class MutationController<T> extends MutationStatusNotifier<T> {
  final BuildContext context;

  MutationController({
    required this.context,
    MutationNotifier<T>? notifier,
  }) : super(notifier: notifier);

  void mutate(MutationCallback<T> mutation) async {
    setIsLoading();

    try {
      final _data = await mutation(context);

      setData(_data);
    } catch (error) {
      setError(error);
    }
  }
}
