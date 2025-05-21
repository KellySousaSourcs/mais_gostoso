// cart_model.dart
import 'package:mais_gostoso/screens/menu_item_model.dart';

class CartModel {
  static final CartModel _instance = CartModel._internal();
  factory CartModel() => _instance;
  CartModel._internal();

  final List<MenuItem> _items = [];

  List<MenuItem> get items => _items;

  void addItem(MenuItem item) {
    _items.add(item);
  }

  void clear() {
    _items.clear();
  }
}
