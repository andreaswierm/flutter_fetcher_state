# Flutter fetcher state

Flutter library for fetching data

## Query

### Query Builder

```dart
Query.builder<List<String>>(
  fetcher: (context) => ExampleRepo.of(context).allItems(), // Returns future
  createStream: (context) => ExampleRepo.of(context).streamAllItems(), // Returns stream
  builder: (context, controller) {
    // handle your view with the controller
  }
)
```

## Mutation

### Mutation Builder

```dart
Mutation.builder<String>(
  builder: (context, controller) {
    return TextButton(
      child: Text("Click me"),
      onPressed: () => controller.mutate((context) => ExampleRepo.of(context).addItem("Hello world"))
    )
  }
)
```
