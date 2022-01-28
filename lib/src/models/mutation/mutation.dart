import 'dart:async';

import 'package:flutter_fetcher_state/src/models/async_state/async_state.dart';
import 'package:flutter_fetcher_state/src/models/async_state_controller/async_state_controller.dart';

class Mutation<T> extends AsyncStateController<T> {
  T? get data => state.data;
  Object? get error => state.error;
  bool get isFetching => state.status == AsyncStatus.fetching;
  bool get hasData => state.data != null;
  bool get hasError => state.error != null;

  Future<T> mutate(FutureOr<T> future) async {
    try {
      state = AsyncState.fetching(state.data);

      final data = await future;

      state = AsyncState.success(data);

      return data;
    } catch (error) {
      state = AsyncState.failure(error);

      rethrow;
    }
  }
}
