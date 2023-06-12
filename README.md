# Stream Store

A sample Flutter application showcasing the usage of streams to implement a shopping cart functionality.

## Overview

The Stream Store is a simple demonstration of how to use streams in Flutter to build a dynamic shopping cart. The app allows users to browse a list of products and add them to their shopping cart. The cart dynamically updates as products are added or removed.

## Features

- View a list of available products
- Add products to the shopping cart
- Clear the shopping cart
- Calculate the total price of items in the cart
- Update the cart UI in real-time using streams

## Demo

https://github.com/je-martinez/stream-store/assets/30488583/8c09ccb3-c3fb-47d6-bda9-ef5fe28c9aa5

## Installation

1. Clone the repository:

```bash
git clone https://github.com/je-martinez/stream-store.git
```

2. Navigate to the project directory:

```bash
cd stream-store
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

## Usage

1. Launch the app on your device or emulator.

2. Browse the list of available products on the home screen.

3. To add a product to the shopping cart, tap on the `plus` button.

4. To clear your shopping cart or remove products from your cart, go to the `Checkout` tab and tap on the `Clear Cart` button also If you want to remove just one product you can tap the `minus` button to remove the desired item of your card.

5. The total price of items in the cart is displayed at the bottom.

6. The cart UI updates in real-time as products are added or removed, thanks to the usage of streams.

## Dependencies

The app uses the following dependencies:

- `rxdart`: RxDart extends the capabilities of Dart Streams and StreamControllers.
- `intl`: Provides internationalization and localization facilities, including message translation, plurals and genders, date/number formatting and parsing, and bidirectional text.

## Implementation

We will create a Singleton class where we will have the functions to modify the Stream. Check `lib/bloc/shopping_cart.bloc.dart`

```
import 'package:rxdart/subjects.dart';
import 'package:stream_store/models/product.dart';

class ShoppingCartBloc {
  //Make Bloc Singleton
  static final ShoppingCartBloc _instance = ShoppingCartBloc._internal();
  ShoppingCartBloc._internal();
  factory ShoppingCartBloc() {
    return _instance;
  }
  //Actually Fields For Stream Use
  static final _cart = ReplaySubject<List<Product>>();
  static final cart = _cart.stream;
  static List<Product> _products = [];

  //Methods
  addProduct(Product product) {
    _products.add(product);
    _cart.add([..._products]);
  }

  removeProduct(int index) {
    _products.removeAt(index);
    _cart.add([..._products]);
  }

  clearCart() {
    _products = [];
    _cart.add([..._products]);
  }

  dispose() {
    _cart.close();
  }
}
```

### Explanation:

- In the first lines you can see the Singleton class declaration.
- Replay what? `ReplaySubject`: A special StreamController that captures all of the items that have been added to the controller, and emits those as the first items to any new listener. And we expose the Stream.
- To make it easier, we are going to have a variable to modify and then push their values to the `ReplaySubject`, in this case, `List<Product> _products`, and we have a couple of methods for basic handling `addProduct`, `removeProduct` and `clearCart`.
- And for good practice also, we will create a method to dispose of this class and close our `ReplaySubject`.

Use `stream` on a Widget, in this case we are going to use `StreamBuilder<T>` widget, this is a widget that builds itself based on the latest snapshot of interaction with a Stream. [Read more here](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html). Check `lib/tabs.dart`

```
...

class ShoppingCartCounter extends StatelessWidget {
  const ShoppingCartCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Tab(icon: Icon(Icons.shopping_cart)),
        const SizedBox(
          width: 10,
        ),
        StreamBuilder(
            stream: ShoppingCartBloc.cart,
            builder: ((context, snapshot) {
              int productCount = 0;
              if (snapshot.hasData) {
                productCount = snapshot.data?.length ?? 0;
              }
              return Text(
                productCount.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              );
            }))
      ],
    );
  }
}

...
```

### Explanation:

- In our implementation, we will use the `stream` to count the products on our shopping cart. We just need to specify our stream on the `stream` field in the `StreamBuilder` widget.
- On the `builder` field, we received two arguments, `context` and `snapshot` we are going to ignore the `context` and just use the `snapshot`, this provided a variety of methods for error handling, access stream data, and validate if the streams have errors or data, so we are going to use check if the snapshot `.hasData` before the count, this to prevent count on null values

Also, we can use streams with the combination State Class on StatefulWidget class. Check `lib/checkout.dart`

```
...

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  StreamSubscription<List<Product>>? _streamSubscription;
  List<Product>? _products;

  double get total {
    if (_products == null) {
      return 0;
    }
    return _products!
        .fold(0, (previousValue, element) => previousValue + element.price);
  }

  @override
  void initState() {
    super.initState();
    _streamSubscription = ShoppingCartBloc.cart.listen((value) {
      setState(() {
        _products = value;
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

...
```

### Explanation:

- We created a variable to handle our stream subscription `StreamSubscription<List<Product>>` and set the subscription on `initState` method, as you can see every time our stream's data changed would update our \_product state variable and re-render our Widget, in this case, our app `checkout`.
- And as a good practice every time our Widget is destroyed we cancel our subscription to prevent memory leaks.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvement, feel free to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
