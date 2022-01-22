import 'package:flutter/material.dart';
import 'package:flutter_fetcher_state/src/models/mutation_status_notifier/mutation_status_notifier.dart';

typedef Mutation<T> = Future<T> Function(BuildContext);

class MutationController<T> extends MutationStatusNotifier<T> {
  final BuildContext context;

  MutationController({
    required this.context,
  });

  void mutate(Mutation<T> mutation) async {
    setIsLoading();

    try {
      final _data = await mutation(context);

      setData(_data);
    } catch (error) {
      setError(error);
    }
  }
}
