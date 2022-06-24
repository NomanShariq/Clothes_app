import 'package:clothing_app/models/screen_arguements.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Cartscreen extends StatefulWidget {
  const Cartscreen({Key? key}) : super(key: key);

  @override
  State<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments?;

    return Scaffold(
    appBar:AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
      size: 25,
      color: Colors.black,
      ),
      title: Text("Cart",
      style: TextStyle
      (color: Colors.black),
      ).centered(),
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          SizedBox(
            height: 34.0,
          ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("shirt.png",width: 70,),
                  Text("Men Denim shirt",style: TextStyle(fontSize: 19),
                  ),
                  Text("\$200",style: TextStyle(fontSize: 19),
                  ),
                IconButton(onPressed: (){
                  setState(() {
                    
                  });
                }, icon: Icon(Icons.remove_circle),
                )   
                 ],
              ),
            ),
            SizedBox(
            height: 34.0,
          ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("shirt.png",width: 70,),
                  Text("Men Denim shirt",style: TextStyle(fontSize: 19),
                  ),
                  Text("\$200",style: TextStyle(fontSize: 19),
                  ),
                IconButton(onPressed: (){

                }, icon: Icon(Icons.remove_circle),
                )   
                 ],
              ),
            ),
            SizedBox(
            height: 34.0,
          ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("shirt.png",width: 70,),
                  Text("Men Denim shirt",style: TextStyle(fontSize: 19),
                  ),
                  Text("\$200",style: TextStyle(fontSize: 19),
                  ),
                IconButton(onPressed: (){

                }, icon: Icon(Icons.remove_circle),
                )   
                 ],
              ),
            ),
            SizedBox(
            height: 34.0,
          ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("shirt.png",width: 70,),
                  Text("Men Denim shirt",style: TextStyle(fontSize: 19),
                  ),
                  Text("\$200",style: TextStyle(fontSize: 19),
                  ),
                IconButton(onPressed: (){

                }, icon: Icon(Icons.remove_circle),
                )   
                 ],
              ),
            ),
            SizedBox(
            height: 34.0,
          ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("shirt.png",width: 70,),
                  Text("Men Denim shirt",style: TextStyle(fontSize: 19),
                  ),
                  Text("\$200",style: TextStyle(fontSize: 19),
                  ),
                IconButton(onPressed: (){

                }, icon: Icon(Icons.remove_circle),
                )   
                 ],
              ),
            ),
        ],
      ),
    ),
    );
  }
}