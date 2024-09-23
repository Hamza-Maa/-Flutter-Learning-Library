import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Exercices/Shopping_Cart/model/product_model.dart';
import 'Home_Screen.dart';

void main() {
  // Create a sample product to pass to MyApp and HomePage.
  final product = Product(
    name: "Sample Product",
    price: 100,
    description: "This is a sample product.",
    category: 'sample',
    imageUrl: '',
    id: 1,
  );

  runApp(
    ProviderScope(
      child: MyApp(product: product),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Home Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 46, 168, 119),
        ),
      ),
      home: HomePage(product: product), // Pass the product to HomePage
    );
  }
}
