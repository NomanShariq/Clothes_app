import 'package:clothing_app/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final String id;
  final String productId;
  final String name;
  final double quantity;
  final double price;

  CartProduct(
    this.id,
    this.productId,
    this.quantity,
    this.price,
    this.name,
  );

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false).removeItem(widget.productId);
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Text('${widget.quantity}'),
            // backgroundImage: AssetImage(widget.imagePath), // image path
            backgroundColor: Colors.black,
            radius: 30,
          ),
          title: Text(widget.name),
          subtitle:
              Text("\$${(widget.price * widget.quantity).toStringAsFixed(2)}"),
          trailing: Text('${widget.quantity}'),
        ),
      ),
    );
  }
}
