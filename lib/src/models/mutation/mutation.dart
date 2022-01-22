import 'package:flutter/widgets.dart';
import 'package:flutter_fetcher_state/src/models/mutation_controller/mutation_controller.dart';
import 'package:flutter_fetcher_state/src/types.dart';
import 'package:flutter_fetcher_state/src/widgets/mutation_builder/mutation_builder.dart';

class Mutation {
  static Widget builder<T>({
    Future<T> Function(BuildContext)? fetcher,
    Stream<T> Function(BuildContext)? createStream,
    required AsyncMutationBuilder<T> builder,
  }) =>
      MutationBuilder<T>(
        builder: builder,
        create: (context) => MutationController(
          context: context,
        ),
      );
}
