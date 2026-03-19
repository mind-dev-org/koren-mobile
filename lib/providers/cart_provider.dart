import 'package:flutter/material.dart';

import '../features/products/data/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<ProductModel> _items = [];

  List<ProductModel> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  double get totalPrice {
    double total = 0;
    for (final item in _items) {
      total += item.price;
    }
    return total;
  }

  void addToCart(ProductModel product) {
    _items.add(product);
    notifyListeners();
  }

  void removeAt(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
