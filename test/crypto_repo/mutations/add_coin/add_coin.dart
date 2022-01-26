import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_fetcher_state/flutter_fetcher_state.dart';

import '../../crypto_repo.dart';

class AddCoinMutation extends Mutation<Coin> {
  final Coin coin;
  final CryptoRepo repo;

  AddCoinMutation({
    required this.coin,
    required this.repo,
  });

  @override
  Future<Coin> mutate(BuildContext context) async {
    await repo.add(coin);

    return coin;
  }
}
