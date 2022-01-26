import 'dart:async';

import 'coin.dart';

export 'coin.dart';
export 'coins.dart';

class CryptoRepo {
  final StreamController<List<Coin>> _streamController = StreamController();
  final List<Coin> coins;

  CryptoRepo({
    required this.coins,
  });

  Stream<List<Coin>> get stream => _streamController.stream;

  Future<void> add(Coin coin) async {
    coins.add(coin);

    _streamController.add(coins);
  }
}
