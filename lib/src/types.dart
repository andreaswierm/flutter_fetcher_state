import 'package:flutter/material.dart';

import 'models/mutation_controller/mutation_controller.dart';
import 'models/query_controller/query_controller.dart';

typedef AsyncQueryBuilder<T> = Widget Function(
  BuildContext,
  QueryController<T>,
);

typedef AsyncMutationBuilder<T> = Widget Function(
  BuildContext,
  MutationController<T>,
);
