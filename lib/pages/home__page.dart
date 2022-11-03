import 'package:clothing_app/pages/Category_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import '../models/cart.dart';
import '../models/screen_arguements.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final productdata = Provider.of<Product>(context);
    final prdcts = productdata.items;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            size: 30,
            color: Colors.black,
          ),
          title: Image(
            image: AssetImage("images/logo.png"),
          ).centered(),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/");
                  },
                  child: Icon(
                    Icons.account_circle,
                    size: 26.0,
                  ),
                )),
            IconButton(
                icon: Icon(Icons.shopping_cart)
                    .badge(color: Colors.grey, count: cart.items.length),
                onPressed: () {
                  Navigator.pushNamed(context, "/cartscreen");
                })
          ],
        ),
        // drawer: Drawer(
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: [
        //       ListTile(
        //         title: const Text('Item 1'),
        //         onTap: () {},
        //       ),
        //       ListTile(
        //         title: const Text('Item 2'),
        //         leading: const Icon(Icons.flight_land),
        //         onTap: () {},
        //       ),
        //       ListTile(
        //         title: const Text('Item 2'),
        //         leading: const Icon(Icons.flight_land),
        //         onTap: () {},
        //       ),
        //       ListTile(
        //         title: const Text('Item 2'),
        //         leading: const Icon(Icons.flight_land),
        //         onTap: () {},
        //       ),
        //       ListTile(
        //         title: const Text('Item 2'),
        //         leading: const Icon(Icons.flight_land),
        //         onTap: () {},
        //       ),
        //       ListTile(
        //         title: const Text('Item 2'),
        //         leading: const Icon(Icons.flight_land),
        //         onTap: () {},
        //       ),
        //       ListTile(
        //         title: const Text('Item 2'),
        //         leading: const Icon(Icons.flight_land),
        //         onTap: () {},
        //       ),
        //     ],
        //   ),
        // ),
        body: ListView(children: [
          Container(
            height: 400.0,
            width: double.infinity,
            child: Carousel(
              images: [
                Image.asset(
                  "images/banner1.png",
                  fit: BoxFit.fill,
                ),
                Image.asset(
                  "images/banner2.png",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "images/banner3.png",
                  fit: BoxFit.fill,
                  // )
                )
              ],
            ),
          ),
          SizedBox(
            height: 35.0,
          ),
          Container(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                minimumSize: MaterialStateProperty.all(const Size(0, 50)),
              ),
              child: Text("Our Categories"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategoryPage()),
                );
              },
            ).centered(),
          ),
          SizedBox(
            height: 35.0,
          ),
          Container(
            height: 400,
            width: 100,
            padding: EdgeInsets.all(10),
            child: Card(
              child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/card1.png"),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                    ),
                    child: Text(
                      "READY TO WEAR",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ).objectBottomCenter().p64()),
            ),
          ),
          SizedBox(
            height: 35.0,
          ),
          Container(
            height: 400,
            width: 100,
            padding: EdgeInsets.all(10),
            child: Card(
              child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/card2.png"),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                    ),
                    child: Text(
                      "READY TO WEAR",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ).objectBottomCenter().p64()),
            ),
          ),
          SizedBox(
            height: 35.0,
          ),
          Container(
            height: 400,
            width: 100,
            padding: EdgeInsets.all(10),
            child: Card(
              child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/card3.png"),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                    ),
                    child: Text(
                      "READY TO WEAR",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ).objectBottomCenter().p64()),
            ),
          ),
          SizedBox(
            height: 35.0,
          ),
          Container(
            height: 400,
            width: 100,
            padding: EdgeInsets.all(10),
            child: Card(
              child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/card4.png"),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                    ),
                    child: Text(
                      "READY TO WEAR",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ).objectBottomCenter().p64()),
            ),
          ),
          SizedBox(
            height: 26.0,
          ),
          Container(
            height: 400,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Card(
              child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/banner4.png"),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                    ),
                    child: Text(
                      "S A L E",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ).objectBottomCenter().p64()),
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          SingleChildScrollView(
            physics: const ScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Column(children: [
              Container(
                height: 150,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: prdcts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                  color: Colors.deepOrangeAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.asset(
                                prdcts[index].image,
                                height: 100,
                                width: 100,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              prdcts[index].title,
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ]),
          ),
          SizedBox(
            height: 25.0,
          ),
          Container(
            margin: EdgeInsets.all(10),
            color: Color.fromARGB(255, 245, 207, 204),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  height: 400,
                  width: 500,
                  child: Image.asset(
                    "images/card.jpg",
                    fit: BoxFit.cover,
                    height: 300,
                    width: 400,
                  ).centered(),
                ),
                Text(
                  "BEAUTY & FRAGRANCES",
                  style: TextStyle(color: Colors.black, fontSize: 29),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  "Create your charm to leave a lasting impression by counting on our captivating and breathtaking fragranirresistible beauty products. Explore the world of our fragrances and beauty range available now!",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25.0,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 245, 207, 204)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                      side: MaterialStateProperty.all(BorderSide(
                        color: Colors.black,
                        width: 5.0,
                      ))),
                  child: Text(
                    "Shop Now",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
        ]));
  }
}
