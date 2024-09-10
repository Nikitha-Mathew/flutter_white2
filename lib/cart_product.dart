import 'package:flutter_white2/product1.dart'; // Import the Product class

class CartProduct {
  final Product product;
  int quantity;

  CartProduct({required this.product, this.quantity = 1});
}
