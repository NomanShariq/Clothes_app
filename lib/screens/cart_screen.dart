import 'package:provider/provider.dart';
import '../models/cart.dart';
import 'package:flutter/material.dart';
import '../widgets/cart_item.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("My Cart",
        style: TextStyle(
          fontSize: 30,
          color: Colors.black),
        ).centered(),
      ),
      //  cart.items.isEmpty ? Column(
      //   children: [
      //     Align(
      //     alignment: Alignment.center,
      //     ),
      //     SizedBox(
      //       height: 10,
      //     ),
      //     Text("No Items Yet",
      //     textAlign: TextAlign.center,
      //     style: TextStyle(
      //       fontSize: 26
      //     ),
      //     ),
      //     Image.asset("zzz.png"),
      //   ],):
      body: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: cart.items.length,
            itemBuilder:(ctx,i) => CartPdt(
              cart.items.values.toList()[i].id,
              cart.items.keys.toList()[i],
              cart.items.values.toList()[i].price,
              cart.items.values.toList()[i].quantity,
              cart.items.values.toList()[i].name
          )),
            ElevatedButton(
              onPressed: (){}, 
              child: Text("Checkout",
              style:TextStyle(
                color:Colors.white,
                fontSize:20)
                )
              ),
        ],
      ),
    );
  }
}
