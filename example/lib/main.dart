import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'coins_repo/coins_repo.dart';
import 'pages/home_page/home_page.dart';
import 'pages/list_coins_page/list_coins_page.dart';

void main() {
  runApp(
    Provider<CoinsRepo>(
      create: (_) => CoinsRepo(
        delay: const Duration(
          seconds: 1,
        ),
      ),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          HomePage.route: (_) => const HomePage(),
          ListCoinsPage.route: (_) => ListCoinsPage(),
        },
      ),
    ),
  );
}
