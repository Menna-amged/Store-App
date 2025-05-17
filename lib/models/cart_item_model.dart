import 'package:flutter_application_2/models/product_modle.dart';

class CartItem {
  final ProductModle product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;
} 