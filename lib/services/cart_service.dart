import 'package:flutter/foundation.dart';
import 'package:flutter_application_2/models/cart_item_model.dart';
import 'package:flutter_application_2/models/product_modle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartService extends ChangeNotifier {
  final List<CartItem> _items = [];
  static const String _cartKey = 'cart_items';
  late SharedPreferences _prefs;

  CartService() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    await loadCart();
  }

  List<CartItem> get items => List.unmodifiable(_items);

  double get totalAmount {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  Future<void> loadCart() async {
    final String? cartData = _prefs.getString(_cartKey);
    if (cartData != null) {
      final List<dynamic> decodedData = json.decode(cartData);
      _items.clear();
      for (var item in decodedData) {
        final product = ProductModle(
          id: item['product']['id'],
          title: item['product']['title'],
          price: item['product']['price'].toDouble(),
          description: item['product']['description'],
          image: item['product']['image'],
          category: item['product']['category'],
        );
        _items.add(CartItem(
          product: product,
          quantity: item['quantity'],
        ));
      }
      notifyListeners();
    }
  }

  Future<void> _saveCart() async {
    final List<Map<String, dynamic>> cartData = _items.map((item) => {
      'product': {
        'id': item.product.id,
        'title': item.product.title,
        'price': item.product.price,
        'description': item.product.description,
        'image': item.product.image,
        'category': item.product.category,
      },
      'quantity': item.quantity,
    }).toList();
    
    await _prefs.setString(_cartKey, json.encode(cartData));
  }

  void addToCart(ProductModle product) {
    final existingIndex = _items.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += 1;
    } else {
      _items.add(CartItem(product: product));
    }
    _saveCart();
    notifyListeners();
  }

  void removeFromCart(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
    _saveCart();
    notifyListeners();
  }

  void updateQuantity(int productId, int quantity) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _items[index].quantity = quantity;
      if (_items[index].quantity <= 0) {
        _items.removeAt(index);
      }
      _saveCart();
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    _saveCart();
    notifyListeners();
  }
} 