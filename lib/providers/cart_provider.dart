import 'package:flutter/material.dart';

import '../features/cart/models/cart_item_model.dart';
import '../features/products/data/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => List.unmodifiable(_items);

  int get itemCount {
    int total = 0;
    for (final item in _items) {
      total += item.quantity;
    }
    return total;
  }

  double get totalPrice {
    double total = 0;
    for (final item in _items) {
      total += item.totalPrice;
    }
    return total;
  }

  void addToCart(ProductModel product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);

    if (index == -1) {
      _items.add(
        CartItemModel(
          product: product,
          quantity: 1,
        ),
      );
    } else {
      final current = _items[index];
      _items[index] = current.copyWith(
        quantity: current.quantity + 1,
      );
    }

    notifyListeners();
  }

  void incrementQuantity(int productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);

    if (index == -1) return;

    final current = _items[index];
    _items[index] = current.copyWith(
      quantity: current.quantity + 1,
    );

    notifyListeners();
  }

  void decrementQuantity(int productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);

    if (index == -1) return;

    final current = _items[index];

    if (current.quantity <= 1) {
      _items.removeAt(index);
    } else {
      _items[index] = current.copyWith(
        quantity: current.quantity - 1,
      );
    }

    notifyListeners();
  }

  void removeByProductId(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
