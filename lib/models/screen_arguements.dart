import 'package:flutter/foundation.dart';

class ScreenArguments with ChangeNotifier {
  final String catid;
  final String id;
  final String image;
  final String title;
  final int price;
  final String desc;

  ScreenArguments({
    required this.catid,
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.desc,
  });
}

class Product with ChangeNotifier {
  final List<ScreenArguments> _items = [
    ScreenArguments(
        id: '1',
        catid: '2',
        image: 'shirt.png',
        title: 'Men Denim shirt',
        price: 200,
        desc:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    ScreenArguments(
        id: '2',
        catid: '2',
        image: 'product1.jpg',
        title: 'Men Denim Jeans',
        price: 4999,
        desc:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    ScreenArguments(
        id: '3',
        catid: '2',
        image: 'product2.jpg',
        title: 'Black Shalwar Suit',
        price: 1999,
        desc:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    ScreenArguments(
        id: '4',
        catid: '2',
        image: 'product3.jpg',
        title: 'Dhingra Mens 3pcs Suit',
        price: 1294,
        desc:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    ScreenArguments(
        id: '5',
        catid: '1',
        image: 'women.png',
        title: 'Radiant Flame Embroidered Shirt',
        price: 9500,
        desc:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    ScreenArguments(
        id: '6',
        catid: '1',
        image: 'women1.png',
        title: 'PINK LILLY EMBROIDERED SHIRT',
        price: 5850,
        desc:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    ScreenArguments(
        id: '7',
        catid: '1',
        image: 'women2.png',
        title: 'PRIMROSE-2PC (SHIRT & DUPATTA)',
        price: 6950,
        desc:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    ScreenArguments(
        id: '8',
        catid: '1',
        image: 'women3.png',
        title: 'SUMMER BLOOM-2PC (SHIRT & DUPATTA)',
        price: 8950,
        desc:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    ScreenArguments(
        id: '9',
        catid: '3',
        image: 'product1.jpg',
        title: "SWIGGLES KID'S COMFORTABLE POLYESTER TROUSER",
        price: 399,
        desc:
            'These Trousers give you the quality, durability, and comfort for all your sporting activities. The Elasticity of the fabric makes it easy to wear. This fabric is so soft and doesnt irritate the skin.'),
    ScreenArguments(
        id: '10',
        catid: '3',
        image: 'product1.jpg',
        title: 'Men Denim Jeans',
        price: 4999,
        desc:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    ScreenArguments(
        id: '11',
        catid: '3',
        image: 'product1.jpg',
        title: 'Men Denim Jeans',
        price: 4999,
        desc:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    ScreenArguments(
        id: '12',
        catid: '3',
        image: 'product1.jpg',
        title: 'Men Denim Jeans',
        price: 4999,
        desc:
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
  ];
  List<ScreenArguments> get items {
    return [..._items];
  }

  ScreenArguments findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }
}
