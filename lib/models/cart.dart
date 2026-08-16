import 'package:flutter/foundation.dart';

class Cartitem {
  String id;
  String name;
  int quantity;
  int price;
  int? originalPrice;
  String image;
  String? size;

  Cartitem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    this.originalPrice,
    required this.image,
    this.size,
  });
}

class Cart with ChangeNotifier {
  Map<String, Cartitem> _items = {};

  Map<String, Cartitem> get items => {..._items};

  int get itemCount => _items.length;

  // Subtotal = sum of current (already-discounted) item prices
  int get subtotal =>
      _items.values.fold(0, (sum, item) => sum + (item.price * item.quantity));

  // Discount = sum of (originalPrice - price) per item
  int get totalDiscount => _items.values.fold(0, (sum, item) {
        if (item.originalPrice == null) return sum;
        return sum + ((item.originalPrice! - item.price) * item.quantity);
      });

  int get amountAfterDiscount => subtotal - totalDiscount;

  int get deliveryFee =>
      amountAfterDiscount == 0 || amountAfterDiscount >= 5000 ? 0 : 200;

  // Total = Subtotal - Discount + Delivery
  int get total => amountAfterDiscount + deliveryFee;

  void addItem(
    String pdtid,
    String name,
    int price, {
    int? originalPrice,
    String image = "images/ladies.jpg",
    String? size,
    int quantity = 1,
  }) {
    if (_items.containsKey(pdtid)) {
      _items.update(
        pdtid,
        (existing) => Cartitem(
          id: existing.id,
          name: existing.name,
          quantity: existing.quantity + quantity,
          price: existing.price,
          originalPrice: existing.originalPrice,
          image: existing.image,
          size: existing.size,
        ),
      );
    } else {
      _items.putIfAbsent(
        pdtid,
        () => Cartitem(
          id: DateTime.now().toString(),
          name: name,
          quantity: quantity,
          price: price,
          originalPrice: originalPrice,
          image: image,
          size: size,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void incrementQuantity(String id) {
    if (!_items.containsKey(id)) return;
    _items.update(
      id,
      (existing) => Cartitem(
        id: existing.id,
        name: existing.name,
        quantity: existing.quantity + 1,
        price: existing.price,
        originalPrice: existing.originalPrice,
        image: existing.image,
        size: existing.size,
      ),
    );
    notifyListeners();
  }

  void decrementQuantity(String id) {
    if (!_items.containsKey(id)) return;
    if (_items[id]!.quantity <= 1) return;
    _items.update(
      id,
      (existing) => Cartitem(
        id: existing.id,
        name: existing.name,
        quantity: existing.quantity - 1,
        price: existing.price,
        originalPrice: existing.originalPrice,
        image: existing.image,
        size: existing.size,
      ),
    );
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
