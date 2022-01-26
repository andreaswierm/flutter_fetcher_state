import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_fetcher_state/flutter_fetcher_state.dart';

import '../../crypto_repo.dart';

class ListCoinsStreamOnlyQuery extends Query<List<Coin>> {
  final CryptoRepo repo;

  ListCoinsStreamOnlyQuery({
    required this.repo,
  });

  @override
  Stream<List<Coin>> streamBuilder(BuildContext context) {
    return repo.stream;
  }
}
