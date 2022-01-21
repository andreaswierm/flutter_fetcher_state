import 'package:flutter/widgets.dart';
import 'package:flutter_fetcher_state/src/models/query_controller/query_controller.dart';
import 'package:flutter_fetcher_state/src/types.dart';
import 'package:flutter_fetcher_state/src/widgets/query_builder/query_builder.dart';

class Query {
  static Widget builder<T>({
    Future<T> Function(BuildContext)? fetcher,
    Stream<T> Function(BuildContext)? createStream,
    required AsyncQueryBuilder<T> builder,
  }) =>
      QueryBuilder<T>(
        builder: builder,
        create: (context) => QueryController(
          fetcher: () => fetcher?.call(context),
          createStream: () => createStream?.call(context),
        ),
      );
}
