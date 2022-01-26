import 'package:flutter/material.dart';

import '../../crypto_repo/crypto_repo.dart';

class ListCoins extends StatelessWidget {
  final List<Coin> coins;

  const ListCoins({
    Key? key,
    required this.coins,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: coins.map((coin) => Text(coin.name)).toList(),
    );
  }
}
