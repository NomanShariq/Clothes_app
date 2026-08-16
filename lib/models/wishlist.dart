import 'package:flutter/foundation.dart';
import 'package:clothing_app/widgets/home/product_card.dart';

class Wishlist with ChangeNotifier {
  final Map<String, ProductCardData> _items = {};

  Map<String, ProductCardData> get items => {..._items};

  int get itemCount => _items.length;

  bool isWishlisted(String key) => _items.containsKey(key);

  void toggle(String key, ProductCardData product) {
    if (_items.containsKey(key)) {
      _items.remove(key);
    } else {
      _items[key] = product;
    }
    notifyListeners();
  }

  void remove(String key) {
    _items.remove(key);
    notifyListeners();
  }
}
