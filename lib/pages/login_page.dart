import 'package:clothing_app/pages/home__page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void validate() {
    if (formkey.currentState!.validate()) {
      print("Ok");
    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {},
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
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
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  Text(
                    "My Account",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ).centered(),
                  Padding(padding: EdgeInsets.only(top: 40)),
                  Text(
                    "Login.",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ).objectCenterLeft(),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Text(
                    "If you have an account with us, please log in.",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ).objectCenterLeft(),
                  Padding(padding: EdgeInsets.only(top: 40)),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("*Required");
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 28.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter password",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("*Required");
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(130, 50)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blueGrey.shade800),
                      ),
                      onPressed: () {
                        /*------- validate----------*/
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Homepage()),
                        );
                      },
                      child: Text("Sign In"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
