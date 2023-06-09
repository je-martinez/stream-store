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

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvement, feel free to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
