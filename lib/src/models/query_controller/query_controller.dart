import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fetcher_state/src/models/query_state/query_state.dart';

class QueryController<T> extends ChangeNotifier {
  final Future<T>? Function()? fetcher;
  final Stream<T>? Function()? createStream;
  QueryState<T> _state = QueryState.empty();

  QueryController({
    this.fetcher,
    this.createStream,
  }) {
    load();
    subscribe();
  }

  bool get hasData => _state.hasData;
  bool get hasError => _state.hasError;
  bool get isEmpty => _state.isEmpty;
  bool get isFetching => _state.isFetching;
  bool get isLoading => _state.isLoading;
  Object? get error => _state.error;
  T? get data => _state.data;

  set state(QueryState<T> newState) {
    _state = newState;

    notifyListeners();
  }

  Future<void> load() async {
    final future = fetcher?.call();

    if (future == null) return;

    state = QueryState.loading();

    return _handleFuture(future);
  }

  Future<void> refetch() async {
    final future = fetcher?.call();

    if (future == null) return;

    state = QueryState.fetching(_state.data);

    return _handleFuture(future);
  }

  void subscribe() {
    final Stream<T>? stream = createStream?.call();

    if (stream == null) return;

    stream.listen((data) {
      state = QueryState.successful(data);
    });
  }

  void debug() {
    final text = """
    ---
    hasData: $hasData
    hasError: $hasError
    isEmpty: $isEmpty
    isFetching: $isFetching
    isLoading: $isLoading
    data: $data
    error: $error
    """;

    // ignore: avoid_print
    print(text);
  }

  Future<void> _handleFuture(Future<T>? future) async {
    try {
      if (future == null) return;

      final T data = await future;

      state = QueryState.successful(data);
    } catch (err) {
      state = QueryState.failure(err);
    }
  }
}
