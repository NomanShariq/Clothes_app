import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:clothing_app/models/screen_arguements.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';

class ProductDetail extends StatelessWidget {
  ProductDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments?;
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          size: 28,
          color: Colors.black,
        ),
        title: Image.asset(
          "assets/logo.png",
          height: 100,
          width: 230,
        ).centered(),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(args!.id, args.title, args.price);
                Navigator.pushNamed(context, "/cartscreen");
              })
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 208, 213, 216),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                    image: AssetImage(args?.image as String),
                  )),
            )),
            Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListTile(
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            args!.title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  args.price as String,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 208, 213, 216),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.remove),
                                          color: Colors.black,
                                        ),
                                      ),
                                      const Text("1"),
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.add),
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Description:",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                              "The first stage is a technical description. Technical descriptions are mostly useful to the people in operations and manufacturing. These descriptions also come in handy while sorting the t-shirts."),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(130, 50)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blueGrey.shade800),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, "/cart");
                              },
                              child: const Text("Add To Cart"),
                            ),
                          ),
                        ]),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
