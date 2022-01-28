import 'dart:async';

import 'package:flutter_fetcher_state/src/models/async_state/async_state.dart';
import 'package:flutter_fetcher_state/src/models/async_state_controller/async_state_controller.dart';

export 'actions/actions.dart';

class BaseQuery<T> extends AsyncStateController<T> {
  Stream<T> Function()? streamBuilder;
  StreamSubscription<T>? _streamSubscription;

  BaseQuery({
    required this.streamBuilder,
  });

  Future<void> subscribe() async {
    if (_streamSubscription != null) return;

    final Stream<T>? stream = streamBuilder?.call();

    if (stream == null) return;

    final Completer completer = Completer();

    _streamSubscription = stream.listen(
      (data) {
        if (completer.isCompleted == false) {
          completer.complete();
        }

        state = AsyncState.success(data);
      },
      onError: (error) {
        if (completer.isCompleted == false) {
          completer.complete();
        }

        state = AsyncState.failure(error);
      },
    );

    await completer.future;
  }

  Future<void> unsubscribe() async {
    await _streamSubscription?.cancel();

    _streamSubscription = null;
  }
}
