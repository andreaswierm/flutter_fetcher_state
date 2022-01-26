import 'package:flutter/widgets.dart';

import 'exceptions/exceptions.dart';

export 'exceptions/exceptions.dart';

abstract class BaseQuery<T> {
  Stream<T> streamBuilder(BuildContext context);
  Future<T> fetcher(BuildContext context);

  Future<T>? fetch(BuildContext context) {
    try {
      return fetcher(context);
    } on FetcherNotImplemented catch (_) {
      return null;
    } catch (error) {
      rethrow;
    }
  }

  Stream<T>? subscribe(BuildContext context) {
    try {
      return streamBuilder(context);
    } on StreamBuilderNotImplemented catch (_) {
      return null;
    } catch (error) {
      rethrow;
    }
  }
}
