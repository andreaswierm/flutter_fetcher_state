import 'package:flutter/material.dart';
import 'package:flutter_fetcher_state/flutter_fetcher_state.dart';

import '../../crypto_repo.dart';

class FailureQuery extends Query<List<Coin>> {
  final Exception exception;

  FailureQuery({
    required this.exception,
  });

  @override
  Future<List<Coin>> fetcher(BuildContext context) async {
    throw exception;
  }
}
