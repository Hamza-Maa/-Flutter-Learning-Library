import 'package:flutter/material.dart';

class ProductGridScreen extends StatelessWidget {
  // Sample list of products
  final List<String> products = List.generate(20, (index) => 'Product $index');

  ProductGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Grid Layout'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determine the number of columns based on screen width
          int crossAxisCount = 2;
          if (constraints.maxWidth > 600) {
            crossAxisCount = 4; // More columns for larger screens
          } else if (constraints.maxWidth > 900) {
            crossAxisCount = 6; // More columns for even larger screens
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      products[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
