import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<int> _favoriteProductIds = {};

  Set<int> get favoriteProductIds => _favoriteProductIds;

  bool isFavorite(int productId) {
    return _favoriteProductIds.contains(productId);
  }

  void toggleFavorite(int productId) {
    if (_favoriteProductIds.contains(productId)) {
      _favoriteProductIds.remove(productId);
    } else {
      _favoriteProductIds.add(productId);
    }
    notifyListeners();
  }

  void clearFavorites() {
    _favoriteProductIds.clear();
    notifyListeners();
  }
}
