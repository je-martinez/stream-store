import 'package:flutter/material.dart';
import 'package:stream_store/bloc/shopping_cart.bloc.dart';
import 'package:stream_store/models/product.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductItem(
          product: Product(
              id: 1,
              name: "A Product",
              description: "Description for Product A",
              price: 15,
              color: Colors.orange),
          actionButton: true,
        ),
        ProductItem(
            product: Product(
                id: 2,
                name: "B Product",
                description: "Description for Product B",
                price: 10,
                color: Colors.red),
            actionButton: true),
        ProductItem(
            product: Product(
                id: 3,
                name: "C Product",
                description: "Description for Product C",
                price: 35,
                color: Colors.yellow),
            actionButton: true),
      ],
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final bool? actionButton;
  const ProductItem({super.key, required this.product, this.actionButton});

  String get name {
    return product.name;
  }

  String get description {
    return product.description;
  }

  String get price {
    return product.price.round().toString();
  }

  Color get color {
    return product.color;
  }

  bool get showButton {
    return actionButton == null ? false : actionButton!;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(
          price,
          style: const TextStyle(
            shadows: [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 1.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 8.0,
                color: Color.fromARGB(125, 0, 0, 255),
              ),
            ],
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        name,
      ),
      subtitle: Text(description),
      trailing: showButton
          ? IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                ShoppingCartBloc().addProduct(product);
              },
            )
          : null,
    );
  }
}
