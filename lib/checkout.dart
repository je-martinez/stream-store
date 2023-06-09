import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stream_store/bloc/shopping_cart.bloc.dart';

import 'models/product.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  StreamSubscription<List<Product>>? _streamSubscription;
  List<Product>? _products;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const ClearCartButton(),
        MyProducts(
          products: _products,
        )
      ],
    );
  }
}

class ClearCartButton extends StatelessWidget {
  const ClearCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
      onPressed: () {
        ShoppingCartBloc().clearCart();
      },
      label: const Text(
        "Clear Cart",
        style: TextStyle(
            fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(208, 43),
      ),
    );
  }
}

class MyProducts extends StatelessWidget {
  List<Product>? products;
  MyProducts({super.key, this.products});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
