import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/product_model.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(
        cartProductProvider); // Watching the cart provider for total items

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  // Navigate to Cart Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cart.length}', // Show the number of items in the cart
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount:
            sampleProducts.length, // Assuming you have a list of products
        itemBuilder: (context, index) {
          final product = sampleProducts[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}

class ProductCard extends ConsumerStatefulWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  ConsumerState<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {
  void increment() {
    if (widget.product.qty < 5) {
      setState(() {
        ref.read(cartProductProvider.notifier).addToCart(widget.product);
      });
    }
  }

  void decrement() {
    setState(() {
      ref.read(cartProductProvider.notifier).removeFromCart(widget.product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Product Image
            SizedBox(
              width: 80,
              height: 80,
              child: Image.network(widget.product.imageUrl, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${widget.product.price}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            // Add to Cart or Quantity Control
            widget.product.qty > 0
                ? Row(
                    children: [
                      IconButton(
                        onPressed: decrement,
                        icon: const Icon(Icons.remove),
                        color: Colors.purple,
                      ),
                      Text(
                        '${widget.product.qty}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        onPressed: increment,
                        icon: const Icon(Icons.add),
                        color: Colors.purple,
                      ),
                    ],
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: increment,
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

// Sample list of products (Replace with actual data)
final List<Product> sampleProducts = [
  Product(
    name: 'Product 1',
    category: 'Category 1',
    price: 20,
    description: 'A nice product',
    imageUrl: 'https://via.placeholder.com/80',
    id: 1,
  ),
  Product(
    name: 'Product 2',
    category: 'Category 2',
    price: 30,
    description: 'Another nice product',
    imageUrl: 'https://via.placeholder.com/80',
    id: 2,
  ),
];
