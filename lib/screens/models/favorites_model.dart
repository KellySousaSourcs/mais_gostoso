import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteItem {
  final String name;
  final String desc;
  final String weight;
  final String image;
  final double price;
  final String? serves;

  FavoriteItem({
    required this.name,
    required this.desc,
    required this.weight,
    required this.image,
    required this.price,
    this.serves,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'desc': desc,
      'weight': weight,
      'image': image,
      'price': price,
      'serves': serves,
    };
  }

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      name: json['name'] ?? '',
      desc: json['desc'] ?? '',
      weight: json['weight'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      serves: json['serves'],
    );
  }
}

class FavoritesModel extends ChangeNotifier {
  static final FavoritesModel _instance = FavoritesModel._internal();
  factory FavoritesModel() => _instance;
  FavoritesModel._internal();

  List<FavoriteItem> _favorites = [];
  List<FavoriteItem> get favorites => _favorites;

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList('favorites') ?? [];

    _favorites = favoritesJson
        .map((json) => FavoriteItem.fromJson(jsonDecode(json)))
        .toList();

    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = _favorites
        .map((item) => jsonEncode(item.toJson()))
        .toList();

    await prefs.setStringList('favorites', favoritesJson);
  }

  bool isFavorite(String itemName) {
    return _favorites.any((item) => item.name == itemName);
  }

  Future<void> toggleFavorite(Map<String, dynamic> itemData) async {
    final itemName = itemData['name'] ?? '';

    if (isFavorite(itemName)) {
      // Remove dos favoritos
      _favorites.removeWhere((item) => item.name == itemName);
    } else {
      // Adiciona aos favoritos
      final favoriteItem = FavoriteItem(
        name: itemName,
        desc: itemData['desc'] ?? '',
        weight: itemData['weight'] ?? '',
        image: itemData['image'] ?? '',
        price: double.tryParse(itemData['price']?.toString().replaceAll(',', '.') ?? '0') ?? 0.0,
        serves: itemData['serves'],
      );
      _favorites.add(favoriteItem);
    }

    await _saveFavorites();
    notifyListeners();
  }

  Future<void> removeFavorite(String itemName) async {
    _favorites.removeWhere((item) => item.name == itemName);
    await _saveFavorites();
    notifyListeners();
  }
}