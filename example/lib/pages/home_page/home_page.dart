import 'package:example/pages/list_coins_page/list_coins_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Examples"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("List coins"),
            onTap: () => Navigator.pushNamed(
              context,
              ListCoinsPage.route,
            ),
          ),
        ],
      ),
    );
  }

  static String get route => "/";
}
