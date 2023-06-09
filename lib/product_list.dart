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
          checkout: false,
        ),
        ProductItem(
            product: Product(
                id: 2,
                name: "B Product",
                description: "Description for Product B",
                price: 10,
                color: Colors.red),
            checkout: false),
        ProductItem(
            product: Product(
                id: 3,
                name: "C Product",
                description: "Description for Product C",
                price: 35,
                color: Colors.yellow),
            checkout: false),
      ],
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final bool? checkout;
  final int? index;
  const ProductItem(
      {super.key, required this.product, this.checkout, this.index});

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

  bool get isCheckout {
    return checkout == null ? false : checkout!;
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
      trailing: IconButton(
        icon: isCheckout ? const Icon(Icons.remove) : const Icon(Icons.add),
        onPressed: () {
          if (isCheckout && index != null) {
            ShoppingCartBloc().removeProduct(index!);
          } else {
            ShoppingCartBloc().addProduct(product);
          }
        },
      ),
    );
  }
}
