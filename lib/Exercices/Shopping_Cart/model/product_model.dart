class Product {
  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.id,
    this.qty = 0, // Default quantity is 0
  });

  final String name;
  final String category;
  final int price;
  final String description;
  final int id;
  final String imageUrl;
  int qty;

  // Factory method for creating a Product from a generic map
  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      name: data['name'],
      category: data['category'],
      id: data['id'],
      price: data['price'],
      imageUrl: data['imageUrl'],
      description: data['description'],
      qty: data['qty'] ?? 0,
    );
  }
}
