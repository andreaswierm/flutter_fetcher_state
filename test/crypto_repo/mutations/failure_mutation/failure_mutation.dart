import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_fetcher_state/flutter_fetcher_state.dart';

import '../../crypto_repo.dart';

class FailureMutation extends Mutation<Coin> {
  final Exception exception;

  FailureMutation({
    required this.exception,
  });

  @override
  Future<Coin> mutate(BuildContext context) async {
    throw exception;
  }
}
