import 'package:flutter/material.dart';
import 'package:flutter_fetcher_state/src/models/mutation/mutation.dart';
import 'package:flutter_fetcher_state/src/models/mutation_notifier/mutation_notifier.dart';
import 'package:flutter_fetcher_state/src/models/mutation_status_notifier/mutation_status_notifier.dart';

class MutationController<T> extends MutationStatusNotifier<T> {
  final BuildContext context;

  MutationController({
    required this.context,
    MutationNotifier<T>? notifier,
  }) : super(notifier: notifier);

  void mutate(Mutation<T> mutation) async {
    setIsLoading();

    try {
      final _data = await mutation.mutate(context);

      setData(_data);
    } catch (error) {
      setError(error);
    }
  }
}
