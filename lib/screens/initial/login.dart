import 'package:data/constants.dart';
import 'package:data/widgets/button.dart';
import 'package:data/widgets/entry_field.dart';
import 'package:data/widgets/entry_field_type.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.15),

            Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            SizedBox(height: size.height * 0.25),

            EntryField(label: "Login", type: EntryFieldType.plaintext),
            EntryField(label: "Password", type: EntryFieldType.password),
            Center(
              child: Button(
                text: "Login",
                color: Colors_.primaryNormal,
                textColor: Colors_.grayscaleWhite,
                onPressed: () => Navigator.popAndPushNamed(context, "/main"),
              )
            ),


            SizedBox(height: size.height * 0.05),

          ],
        ),
      ),
    );
  }
}
