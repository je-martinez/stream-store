import 'package:flutter/material.dart';

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
                Tab(icon: Icon(Icons.shopping_cart)),
              ],
            ),
            title: const Text('Stream Store'),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}
