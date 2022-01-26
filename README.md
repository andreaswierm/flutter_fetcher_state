# Flutter fetcher state

Flutter library for fetching data

## Query

```dart
class ListItems extends Query<List<Item>> {
  @override
  Future<List<Item>> fetcher(BuildContext context) {
    return Future.value([]);
  }

  @override
  Stream<List<Item>> streamBuilder(BuildContext context) {
    return const Stream.empty();
  }
}
```

### Query Builder

```dart
Query.builder<List<String>>(
  query: ListItems(),
  builder: (context, controller) {
    // handle your view with the controller
  }
)
```

## Mutation

```dart
class AddItemMutation extends Mutation<Item> {
  final Item item;

  AddItemMutation({
    required this.item,
  });

  @override
  Future<Item> mutate(BuildContext context) async {
    // add the item

    return item;
  }
}

```

### Mutation Builder

```dart
Mutation.builder<String>(
  builder: (context, controller) {
    return TextButton(
      child: Text("Click me"),
      onPressed: () => controller.mutate(
        AddItemMutation(
          item: Item(),
        ),
      )
    )
  }
)
```
