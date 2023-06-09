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
