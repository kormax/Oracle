import 'package:data/constants/colors.dart';
import 'package:data/widgets/button.dart';
import 'package:data/widgets/entry_field.dart';
import 'package:data/widgets/entry_field_type.dart';
import 'package:flutter/material.dart';


class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
              "Sign up",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            SizedBox(height: size.height * 0.15),

            EntryField(label: "Login", type: EntryFieldType.plaintext),
            EntryField(label: "Email", type: EntryFieldType.plaintext),
            EntryField(label: "Password", type: EntryFieldType.password),
            EntryField(label: "Retype password", type: EntryFieldType.password),
            Center(
                child: Button(
                  text: "Sign up",
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
