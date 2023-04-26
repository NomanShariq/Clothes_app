import 'package:clothing_app/models/screen_arguements.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PdtItem extends StatelessWidget {
  final String name;
  final String image;
  final String price;

  const PdtItem({Key? key, 
    required this.name,
    required this.image,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ScreenArguments>(context);

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.black)),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed("/detail", arguments: product.id);
          },
          child: GridTile(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                  image: AssetImage(image),
                )),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.black87,
                title: Text(name),
                trailing: Text(
                  price,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
