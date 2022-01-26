import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_fetcher_state/flutter_fetcher_state.dart';

import '../../crypto_repo.dart';

class ListCoinsQuery extends Query<List<Coin>> {
  final CryptoRepo repo;

  ListCoinsQuery({
    required this.repo,
  });

  @override
  Future<List<Coin>> fetcher(BuildContext context) {
    return Future.value(repo.coins);
  }

  @override
  Stream<List<Coin>> streamBuilder(BuildContext context) {
    return repo.stream;
  }
}
