class MutationNotifier<T> {
  final void Function(T)? _onSuccess;
  final void Function(Object)? _onError;

  const MutationNotifier({
    void Function(Object)? onError,
    void Function(T)? onSuccess,
  })  : _onError = onError,
        _onSuccess = onSuccess;

  void onSuccess(T data) {
    _onSuccess?.call(data);
  }

  void onError(Object error) {
    _onError?.call(error);
  }
}
