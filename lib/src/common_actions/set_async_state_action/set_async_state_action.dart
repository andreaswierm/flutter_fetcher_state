import 'package:flutter_fetcher_state/src/models/async_state/async_state.dart';
import 'package:flutter_fetcher_state/src/models/async_state_action/async_state_action.dart';
import 'package:flutter_fetcher_state/src/models/async_state_controller/async_state_controller.dart';

class SetAsyncStateAction<T> implements AsyncStateAction<T> {
  final AsyncState<T> state;

  SetAsyncStateAction({
    required this.state,
  });

  @override
  Future<void> execute(AsyncStateController<T> controller) async {
    controller.state = state;
  }
}
