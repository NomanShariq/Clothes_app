import 'package:flutter/material.dart';
import '../models/cart.dart';

class CheckoutItem extends StatelessWidget {
  final CartItem cartItem;

  CheckoutItem(this.cartItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 180,
            child: Text(
              cartItem.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            '\$${cartItem.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Text(
            '${cartItem.quantity}x',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
