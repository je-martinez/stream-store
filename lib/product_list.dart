import 'package:flutter/material.dart';
import 'package:stream_store/bloc/shopping_cart.bloc.dart';
import 'package:stream_store/models/product.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const CircleAvatar(child: Text('A')),
          title: const Text('Headline'),
          subtitle: const Text('Supporting text'),
          trailing: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final newProduct = Product(
                  id: 25,
                  name: "Product",
                  description: "Description",
                  price: 50);
              appCart.addProduct(newProduct);
            },
          ),
        )
      ],
    );
  }
}

class ShoppingCartButton extends StatelessWidget {
  const ShoppingCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
