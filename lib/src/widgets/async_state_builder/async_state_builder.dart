import 'package:flutter/widgets.dart';
import 'package:flutter_fetcher_state/src/models/async_state_controller/async_state_controller.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';

class AsyncStateBuilder<T> extends StatelessWidget {
  final WidgetBuilder builder;
  final List<AsyncStateController> states;

  const AsyncStateBuilder({
    Key? key,
    required this.builder,
    required this.states,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiValueListenableBuilder(
      builder: (context, _, __) => builder(context),
      valueListenables: states
          .map(
            (state) => state.stateValueNotifier,
          )
          .toList(),
    );
  }
}
