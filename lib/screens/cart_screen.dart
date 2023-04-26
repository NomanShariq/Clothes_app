import 'package:clothing_app/pages/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/cart.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          size: 30,
          color: Colors.black,
        ),
        title: const Text(
          "My Cart",
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
          ),
        ).centered(),
      ),
      body: cart.items.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Align(
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "No Items Yet",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              ],
            )
          : Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cart.items.length,
                    itemBuilder: (ctx, i) => CartProduct(
                      cart.items.keys.toList()[i],
                      cart.items.values.toList()[i].id,
                      cart.items.values.toList()[i].quantity.toDouble(),
                      cart.items.values.toList()[i].price.toDouble(),
                      cart.items.values.toList()[i].name,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Checkout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
