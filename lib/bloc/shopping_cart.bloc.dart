import 'dart:async';

import 'package:stream_store/models/product.dart';

class ShoppingCartBloc {
  final StreamController<List<Product>> _cart =
      StreamController<List<Product>>();
  Sink get updateCart => _cart.sink;
  Stream<List<Product>> get getCart => _cart.stream;

  addProduct(Product product) {
    getCart.take(1).listen((products) {
      List<Product> newProducts = [...products, product];
      updateCart.add(newProducts);
    });
  }

  removeProduct(int id) {
    getCart.take(1).listen((products) {
      List<Product> currentProducts = [...products];
      currentProducts.removeWhere((item) => item.id == id);
      updateCart.add(currentProducts);
    });
  }

  clearCart(Product product) {
    updateCart.add([]);
  }
}

final appCart = ShoppingCartBloc();
