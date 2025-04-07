import 'package:flutter/material.dart';

class FavoriteProperty {
  final String id;
  final String title;
  final double price;
  final double rating;
  final String location;
  final String imgURL;

  FavoriteProperty({
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.location,
    required this.imgURL,
  });
}

class FavoriteProvider with ChangeNotifier {
  final List<FavoriteProperty> _favorites = [];

  List<FavoriteProperty> get favorites => _favorites;

  void addFavorite(FavoriteProperty property) {
    if (!_favorites.any((p) => p.id == property.id)) {
      _favorites.add(property);
      notifyListeners();
    }
  }

  void removeFavorite(String propertyId) {
    _favorites.removeWhere((p) => p.id == propertyId);
    notifyListeners();
  }

  bool isFavorite(String propertyId) {
    return _favorites.any((p) => p.id == propertyId);
  }

  void toggleFavorite(FavoriteProperty property) {
    if (isFavorite(property.id)) {
      removeFavorite(property.id);
    } else {
      addFavorite(property);
    }
  }
}
