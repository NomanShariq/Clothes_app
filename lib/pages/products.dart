import 'package:clothing_app/pages/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:clothing_app/models/screen_arguements.dart';

class Products extends StatefulWidget {
  @override
  ProductsState createState() => ProductsState();
}

class ProductsState extends State<Products>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            size: 25,
            color: Colors.black,
          ),
          title: Image.asset(
            "logo.png",
            height: 110,
            width: 210,
          ).centered(),
          actions: <Widget>[
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, "/cart");
              })
        ],),
      body: Stack(
        children: [
          Row(
            children: [
              SizedBox(height: 20),
              groupOfCards(
                  'Men Denim shirt',
                  '200',
                  'shirt.png',
                  "1",
                  'Men Denim Jeans',
                  '4999',
                  'product1.jpg',
                  "2",
              ),
              groupOfCards(
                  'BLACK SHALWAR SUIT',
                  '1999',
                  'product2.jpg',
                  "3",
                  'Dhingra Mens 3pcs Suit',
                  '1294',
                  'product3.jpg',
                  "4",),
            ],
          ),
        ],
      ),
    );
  }

  Widget groupOfCards(
      String title1,
      String price,
      String image1,
      String id1,
      String title2,
      String subtitle2,
      String image2,
      String id2) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          card(title1, price, image1,id1),
        ],
      ),
    );
  }

  Widget card(String title, String price, String image, String id) {
    return Opacity(
      opacity: _animation.value,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Color.fromARGB(0, 151, 99, 99),
        onTap: () {
          Navigator.pushNamed(context, "/productdetail");
        },
        child: Container(
          width: 210,
          height: 240,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 50),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Image.asset(
                image, fit: BoxFit.fill, 
                width: 140,
                height: 130),
              Container(
                height: 100,
                width: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(.8),
                      ),
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


