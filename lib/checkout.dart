import 'package:flutter/material.dart';
import 'package:stream_store/bloc/shopping_cart.bloc.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 10,
        ),
        ClearCartButton()
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
        appCart.clearCart();
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
