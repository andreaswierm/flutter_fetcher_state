import 'package:flutter_fetcher_state/src/models/async_state_action/async_state_action.dart';
import 'package:flutter_fetcher_state/src/models/base_query/base_query.dart';

class UnsubscribeAction<T> implements AsyncStateAction<T> {
  @override
  Future<void> execute(BaseQuery<T> controller) async {
    await controller.unsubscribe();
  }
}
