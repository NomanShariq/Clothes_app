import 'package:clothing_app/pages/Category_page.dart';
import 'package:clothing_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import '../models/cart.dart';
import '../models/screen_arguements.dart';
import '../screens/cart_screen.dart';
import '../widgets/my_drawer.dart';

class Homepage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  Homepage({Key? key}) : super(key: key);
  void search(String query) {
    // Perform search action here
  }
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
          iconTheme: const IconThemeData(
            size: 30,
            color: Colors.black,
          ),
          title: const Image(
            image: AssetImage("images/logo.png"),
          ).centered(),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  child: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Search'),
                            content: TextField(
                              controller: searchController,
                              decoration: const InputDecoration(
                                hintText: 'Enter search query...',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  String query = searchController.text.trim();
                                  search(query);
                                  Navigator.pop(context);
                                },
                                child: const Text('Search'),
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(130, 50)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blueGrey.shade800),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const LoginPage()),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.account_circle,
                    size: 26.0,
                  ),
                )),
            IconButton(
              icon: const Icon(Icons.shopping_cart)
                  .badge(color: Colors.grey, count: cart.items.length),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const CartScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
        drawer: const MyDrawer(),
        body: ListView(children: [
          SizedBox(
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
          const SizedBox(
            height: 35.0,
          ),
          Container(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                minimumSize: MaterialStateProperty.all(const Size(0, 50)),
              ),
              child: const Text("Our Categories"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategoryPage()),
                );
              },
            ).centered(),
          ),
          const SizedBox(
            height: 35.0,
          ),
          Container(
            height: 400,
            width: 100,
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Container(
                  decoration: const BoxDecoration(
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
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                    ),
                    child: const Text(
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
          const SizedBox(
            height: 35.0,
          ),
          Container(
            height: 400,
            width: 100,
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Container(
                  decoration: const BoxDecoration(
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
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                    ),
                    child: const Text(
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
          const SizedBox(
            height: 35.0,
          ),
          Container(
            height: 400,
            width: 100,
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Container(
                  decoration: const BoxDecoration(
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
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                    ),
                    child: const Text(
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
          const SizedBox(
            height: 35.0,
          ),
          Container(
            height: 400,
            width: 100,
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Container(
                  decoration: const BoxDecoration(
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
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                    ),
                    child: const Text(
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
          const SizedBox(
            height: 26.0,
          ),
          Container(
            height: 400,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Container(
                  decoration: const BoxDecoration(
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
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                    ),
                    child: const Text(
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
          const SizedBox(
            height: 25.0,
          ),
          SingleChildScrollView(
            physics: const ScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Column(children: [
              SizedBox(
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
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                  color: Colors.deepOrangeAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.asset(
                                prdcts[index].image,
                                height: 100,
                                width: 100,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              prdcts[index].title,
                              style: const TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ]),
          ),
          const SizedBox(
            height: 25.0,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            color: const Color.fromARGB(255, 245, 207, 204),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  height: 400,
                  width: 500,
                  child: Image.asset(
                    "images/card.jpg",
                    fit: BoxFit.cover,
                    height: 300,
                    width: 400,
                  ).centered(),
                ),
                const Text(
                  "BEAUTY & FRAGRANCES",
                  style: TextStyle(color: Colors.black, fontSize: 29),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 25.0,
                ),
                const Text(
                  "Create your charm to leave a lasting impression by counting on our captivating and breathtaking fragranirresistible beauty products. Explore the world of our fragrances and beauty range available now!",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 25.0,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 245, 207, 204)),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      side: MaterialStateProperty.all(const BorderSide(
                        color: Colors.black,
                        width: 5.0,
                      ))),
                  child: const Text(
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
