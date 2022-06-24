import 'package:clothing_app/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPdt extends StatefulWidget {
  final String id;
  final String productid;
  final String name;
  final int quantity;
  final double price;

  CartPdt(
    this.id,
    this.productid,
    this.quantity,
    this.price,
    this.name,
  );

  @override
  State<CartPdt> createState() => _CartPdtState();
}

class _CartPdtState extends State<CartPdt> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red
        ),
        onDismissed: Provider.of<Cart>(context).removeItem(widget.productid),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(
              child: Text('\$${widget.quantity}'),
            ),
          ),
          title: Text(widget.name),
          subtitle: Text("\$${(widget.price * widget.quantity)}"),
          trailing: Text('${widget.price} x'),
        ),
      ),
    );
  }
}
