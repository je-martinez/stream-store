import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stream_store/bloc/shopping_cart.bloc.dart';

import 'models/product.dart';
import 'product_list.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CheckoutHeader(),
        MyProducts(
          products: _products,
        ),
        CheckoutFooter(total: total)
      ],
    );
  }
}

class CheckoutHeader extends StatelessWidget {
  const CheckoutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Center(
            child: ElevatedButton.icon(
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
              fixedSize: const Size(208, 43), backgroundColor: Colors.red),
        )));
  }
}

class MyProducts extends StatelessWidget {
  final List<Product>? products;
  const MyProducts({super.key, this.products});

  @override
  Widget build(BuildContext context) {
    List<Widget> wProduct = [];
    if (products != null) {
      for (final item in products!) {
        wProduct.add(ProductItem(
          product: item,
          checkout: true,
        ));
      }
    } else {
      wProduct.add(const ListTile(title: Text("No products!")));
    }

    return Expanded(
        child: ListView(
      children: wProduct,
    ));
  }
}

class CheckoutFooter extends StatelessWidget {
  final double total;
  const CheckoutFooter({super.key, required this.total});

  String get formatValue {
    return NumberFormat.simpleCurrency(locale: "EN-us", decimalDigits: 2)
        .format(total);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      color: Colors.blue,
      child: Center(
          child: Text(
        formatValue,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      )),
    );
  }
}
