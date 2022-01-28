import 'package:flutter/widgets.dart';
import 'package:flutter_fetcher_state/src/models/mutation/mutation.dart';
import 'package:flutter_fetcher_state/src/widgets/async_state_builder/async_state_builder.dart';

class MutationBuilder<T> extends StatefulWidget {
  final Mutation<T> Function(BuildContext) create;
  final Widget Function(BuildContext, Mutation<T> query) builder;

  const MutationBuilder({
    Key? key,
    required this.builder,
    required this.create,
  }) : super(key: key);

  @override
  _MutationBuilderState createState() => _MutationBuilderState<T>();
}

class _MutationBuilderState<T> extends State<MutationBuilder<T>> {
  late final Mutation<T> mutation = widget.create(context);

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      states: [mutation],
      builder: (context) => widget.builder(context, mutation),
    );
  }
}
