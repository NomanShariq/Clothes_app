import 'package:flutter/foundation.dart';

class Cartitem {
  String id;
  String name;
  double quantity;
  int price;

  Cartitem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, Cartitem> _items = {};

  Map<String, Cartitem> get items {
    return {..._items};
  }

  int get itemCount {
    return items.length;
  }

  void addItem(String pdtid, String name, int price) {
    if (_items.containsKey(pdtid)) {
      _items.update(
          pdtid,
          (existingCartItem) => Cartitem(
              id: DateTime.now().toString(),
              name: existingCartItem.name,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price));
    } else {
      _items.putIfAbsent(
          pdtid,
          () => Cartitem(
              id: DateTime.now().toString(),
              name: name,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id]!.quantity > 1) {
      _items.update(
          id,
          (existingCartItem) => Cartitem(
              id: DateTime.now().toString(),
              name: existingCartItem.name,
              quantity: existingCartItem.quantity - 1,
              price: existingCartItem.price));
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
