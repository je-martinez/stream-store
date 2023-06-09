import 'dart:async';

import 'package:stream_store/models/product.dart';

class ShoppingCartBloc {
  final StreamController<List<Product>> _cart =
      StreamController<List<Product>>.broadcast();
  Sink get updateCart => _cart.sink;
  Stream<List<Product>> get getCart => _cart.stream;
  List<Product> _products = [];

  addProduct(Product product) {
    _products.add(product);
    updateCart.add([..._products]);
  }

  removeProduct(int id) {
    _products.removeWhere((item) => item.id == id);
    updateCart.add([..._products]);
  }

  clearCart(Product product) {
    _products = [];
    updateCart.add([]);
  }

  dispose() {
    _cart.close();
  }
}

final appCart = ShoppingCartBloc();
