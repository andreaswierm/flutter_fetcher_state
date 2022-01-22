import 'package:flutter/material.dart';

enum _MutationStatus {
  loading,
  fetching,
  settled,
}

class QueryStatusNotifier<T> extends ChangeNotifier {
  _MutationStatus _status = _MutationStatus.settled;
  T? _data;
  Object? _error;

  bool get isLoading => _status == _MutationStatus.loading;
  bool get isFetching =>
      _status == _MutationStatus.loading || _status == _MutationStatus.fetching;
  bool get isEmpty => _data == null;
  bool get hasError => _error != null;
  bool get hasData => _data != null;
  T? get data => _data;
  Object? get error => _error;

  void setIsLoading() {
    _setState(status: _MutationStatus.loading);
  }

  void setFetching() {
    _setState(
      status: _MutationStatus.fetching,
      data: _data,
    );
  }

  void setData(T data) {
    _setState(
      status: _MutationStatus.settled,
      data: data,
    );
  }

  void setError(Object error) {
    _setState(
      status: _MutationStatus.settled,
      error: error,
    );
  }

  void _setState({
    required _MutationStatus status,
    T? data,
    Object? error,
  }) {
    _status = status;
    _data = data;
    _error = error;

    notifyListeners();
  }
}
