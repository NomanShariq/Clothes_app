import 'package:clothing_app/models/screen_arguements.dart';
import 'package:clothing_app/widgets/pdct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class Allproducts extends StatelessWidget {
  const Allproducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryid = ModalRoute.of(context)?.settings.arguments as String;
    final productdata = Provider.of<Product>(context);
    final rawData = productdata.items;
    final prdcts = rawData.filter((item) => item.catid == categoryid).toList();

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            size: 30,
            color: Colors.black,
          ),
          title: Image.asset(
            "images/logo.png",
            height: 100,
            width: 250,
          ).centered()),
      body: GridView.builder(
        physics: ScrollPhysics(),
        itemCount: prdcts.length,
        shrinkWrap: true,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: prdcts[i],
          child: PdtItem(
            name: prdcts[i].title,
            image: prdcts[i].image,
            price: prdcts[i].price.toString(),
          ),
        ),
      ),
    );
  }
}
