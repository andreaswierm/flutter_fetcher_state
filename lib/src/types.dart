import 'package:flutter/material.dart';

import 'models/query_controller/query_controller.dart';

typedef AsyncQueryBuilder<T> = Widget Function(
  BuildContext,
  QueryController<T>,
);
