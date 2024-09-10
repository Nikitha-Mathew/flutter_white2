import 'package:flutter/material.dart';
import 'package:flutter_white2/product1.dart'; // Import the Product class

// provider for the cart screen
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(Product product) {
    final existingItemIndex =
        _cartItems.indexWhere((item) => item.product == product);

    if (existingItemIndex >= 0) {
      _cartItems[existingItemIndex].quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }

    notifyListeners();
  }

  void removeFromCart(Product product) {
    final existingItemIndex =
        _cartItems.indexWhere((item) => item.product == product);

    if (existingItemIndex >= 0) {
      if (_cartItems[existingItemIndex].quantity > 1) {
        _cartItems[existingItemIndex].quantity--;
      } else {
        _cartItems.removeAt(existingItemIndex);
      }
    }

    notifyListeners();
  }

  int get cartItemCount =>
      _cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount {
    return _cartItems.fold(
        0.0, (sum, item) => sum + item.product.price * item.quantity);
  }
}
