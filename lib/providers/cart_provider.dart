import 'package:flutter/material.dart';

import '../features/products/data/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<ProductModel> _items = [];

  List<ProductModel> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  void addToCart(ProductModel product) {
    _items.add(product);
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _items.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
