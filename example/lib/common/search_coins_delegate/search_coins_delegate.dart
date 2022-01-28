import 'package:example/coins_repo/coins_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fetcher_state/flutter_fetcher_state.dart';

class SearchCoinsDelegate extends SearchDelegate<Coin?> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return QueryBuilder<List<Coin>>(
      create: (_) => Query.fetcher(
        () => CoinsRepo.of(context).search(name: query),
      ),
      builder: (context, controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final List<Coin> results = controller.data ?? [];

        if (results.isEmpty) {
          return const Center(
            child: Text("No results"),
          );
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final coin = results[index];

            return ListTile(
              title: Text(coin.name),
              onTap: () => close(context, coin),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
