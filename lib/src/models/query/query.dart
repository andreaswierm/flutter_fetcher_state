import 'package:flutter/widgets.dart';
import 'package:flutter_fetcher_state/src/models/base_query/base_query.dart';
import 'package:flutter_fetcher_state/src/models/query_controller/query_controller.dart';
import 'package:flutter_fetcher_state/src/types.dart';
import 'package:flutter_fetcher_state/src/widgets/query_builder/query_builder.dart';

abstract class Query<T> extends BaseQuery<T> {
  @override
  Future<T> fetcher(BuildContext context) {
    throw FetcherNotImplemented();
  }

  @override
  Stream<T> streamBuilder(BuildContext context) {
    throw StreamBuilderNotImplemented();
  }

  static Widget builder<T>({
    required Query<T> query,
    required AsyncQueryBuilder<T> builder,
  }) =>
      QueryBuilder<T>(
        builder: builder,
        create: (context) => QueryController(
          query: query,
          getBuildContext: () => context,
        ),
      );
}
