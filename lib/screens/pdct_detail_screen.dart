import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../models/cart.dart';
import '../models/screen_arguements.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedPdt = Provider.of<Product>(context).findById(productId);
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              size: 30,
              color: Colors.black,
            ),
            title: Image.asset(
              "logo.png",
              height: 100,
              width: 250,
            ).centered(),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Container(
            height: 300,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                    image: AssetImage(loadedPdt.image as String),
                  )),
            ) 
            ),
            SizedBox(
            height: 4.0,
          ),
          Text(
            loadedPdt.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ).centered(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              '${loadedPdt.desc}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Price: \$${loadedPdt.price}',
              style: TextStyle(
                fontSize: 20,
              ),
            ).objectCenterLeft(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          cart.addItem(productId, loadedPdt.title, loadedPdt.price);
        },
        child: Icon(
          Icons.shopping_cart,
          size: 30,
          color: Colors.black,
        ).badge(color:Colors.black,count: cart.items.length),
      ),
    );
  }
}