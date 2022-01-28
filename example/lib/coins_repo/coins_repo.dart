import 'dart:async';

import 'package:example/coins_repo/models/coins/coins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/coin/coin.dart';

export 'models/coin/coin.dart';

class CoinsRepo {
  final List<Coin> _coins = [
    ethereumCoin,
    bitcoinCoin,
    tetherCoin,
  ];

  final Duration _delay;
  final StreamController<List<Coin>> _streamController =
      StreamController.broadcast();

  CoinsRepo({
    Duration? delay,
  }) : _delay = delay ?? const Duration();

  Stream<List<Coin>> get stream => _streamController.stream;

  List<Coin> get coins => _coins;

  Future<List<Coin>> search({
    required String name,
  }) {
    return fetchAll().then(
      (coins) => coins
          .where(
            (coin) => coin.name.contains(name),
          )
          .toList(),
    );
  }

  Future<List<Coin>> fetchAll() => Future.delayed(
        _delay,
        () => coins,
      );

  Future<Coin> add(Coin coin) async {
    _coins.add(coin);

    _streamController.add(_coins);

    return Future.delayed(_delay, () => coin);
  }

  static CoinsRepo of(BuildContext context) {
    return context.read<CoinsRepo>();
  }
}
