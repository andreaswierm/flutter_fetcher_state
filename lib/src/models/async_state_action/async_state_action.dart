import 'package:flutter_fetcher_state/src/models/async_state_controller/async_state_controller.dart';

abstract class AsyncStateAction<T> {
  Future<void> execute(covariant AsyncStateController<T> controller);
}
