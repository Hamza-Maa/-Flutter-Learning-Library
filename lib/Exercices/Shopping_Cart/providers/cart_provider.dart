import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/product_model.dart';

class CartProductNotifier extends StateNotifier<List<Product>> {
  CartProductNotifier() : super([]);

  void addToCart(Product product) {
    if (state.contains(product)) {
      product.qty++;
      print("Productqtyyyy ${product.qty}");
    } else {
      state.add(product);
      product.qty++;
    }
    state = List.from(
        state); // This ensures the list updates and notifies listeners.
  }

  void removeFromCart(Product product) {
    if (product.qty == 1) {
      product.qty--;
      state.remove(product);
    } else if (product.qty > 1) {
      product.qty--;
      print(product.qty);
    }
    state = List.from(
        state); // This ensures the list updates and notifies listeners.
  }

  // Method to calculate the total price of items in the cart
  double totalPrice() {
    double total = 0.0;
    for (var product in state) {
      total += product.price * product.qty;
    }
    return total;
  }
}

// Provider for the cart product notifier
final cartProductProvider =
    StateNotifierProvider<CartProductNotifier, List<Product>>((ref) {
  return CartProductNotifier();
});
