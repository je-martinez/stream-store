import 'package:flutter/material.dart';
import 'package:stream_store/product_list.dart';

import 'bloc/shopping_cart.bloc.dart';
import 'checkout.dart';

class StoreTabs extends StatelessWidget {
  const StoreTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.store_mall_directory_outlined)),
                // ,
                ShoppingCartCounter()
              ],
            ),
            title: const Text('Stream Store'),
          ),
          body: const TabBarView(
            children: [
              ProductList(),
              Checkout(),
            ],
          ),
        ),
      ),
    );
  }
}

class ShoppingCartCounter extends StatelessWidget {
  const ShoppingCartCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Tab(icon: Icon(Icons.shopping_cart)),
        const SizedBox(
          width: 10,
        ),
        StreamBuilder(
            stream: appCart.getCart,
            builder: ((context, snapshot) {
              int productCount = 0;
              if (snapshot.hasData) {
                productCount = snapshot.data?.length ?? 0;
              }
              return Text(
                productCount.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              );
            }))
      ],
    );
  }
}
