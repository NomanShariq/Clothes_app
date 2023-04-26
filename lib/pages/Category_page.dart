import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

import 'home__page.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map> categories = [
      {'id': '1', 'name': 'Women', 'image': 'images/banner1.png'},
      {'id': '2', 'name': 'Men', 'image': 'images/banner2.png'},
      {'id': '3', 'name': 'Kids', 'image': 'images/kids.jpg'},
    ];
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              size: 30,
              color: Colors.black,
            ),
            title: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Homepage();
                    },
                  ),
                );
              },
              child: Image.asset(
                "images/logo.png",
                height: 100,
                width: 250,
              ).centered(),
            )),
        body: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: [
                    InkWell(
                      hoverColor: Colors.white,
                      onTap: () {
                        Navigator.of(context).pushNamed("/allproducts",
                            arguments: categories[index]["id"]);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 50),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          categories[index]['image'],
                          fit: BoxFit.fill,
                          height: 100,
                          width: 120,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Text(
                        categories[index]['name'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
