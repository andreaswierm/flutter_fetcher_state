import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fetcher_state/src/models/async_state/async_state.dart';
import 'package:flutter_fetcher_state/src/models/async_state_action/async_state_action.dart';

abstract class AsyncStateController<T> {
  final ValueNotifier<AsyncState<T>> _state;

  AsyncStateController({
    AsyncState<T>? initialState,
  }) : _state = ValueNotifier(
          initialState ?? AsyncState.empty(),
        );

  ValueNotifier<AsyncState<T>> get stateValueNotifier => _state;

  set state(AsyncState<T> newState) => _state.value = newState;

  AsyncState<T> get state => _state.value;

  Future<void> executeAction(AsyncStateAction<T> action) {
    return action.execute(this);
  }

  Future<void> executeActions(List<AsyncStateAction<T>> actions) {
    return Future.forEach(actions, executeAction);
  }
}
