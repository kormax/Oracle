import 'package:data/constants.dart';
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
    double margin = size.width * 0.1;

    return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: margin),

                Text(
                    "Sign up",
                    style: Text_.heading1
                ),

                Spacer(),

                EntryField(label: "Login", type: EntryFieldType.plaintext),
                EntryField(label: "Email", type: EntryFieldType.plaintext),
                EntryField(label: "Password", type: EntryFieldType.password),
                EntryField(label: "Retype password", type: EntryFieldType.password),

                Spacer(),

                Container(
                    margin: EdgeInsets.symmetric(horizontal: margin, vertical: 16),
                    width: size.width - margin * 2,
                    child: Button(
                      text: "Signup",
                      color: Colors_.primaryNormal,
                      textColor: Colors_.grayscaleWhite,
                      onPressed: () => Navigator.popAndPushNamed(context, "/main"),
                    )
                ),

                Container(
                    margin: EdgeInsets.symmetric(horizontal: margin),
                    width: size.width - margin * 2,
                    child: Button(
                      text: "Or login",
                      color: Colors_.grayscaleWhite,
                      textColor: Colors_.primaryNormal,
                      onPressed: () => Navigator.popAndPushNamed(context, "/login"),
                    )
                ),

                SizedBox(height: margin),
              ],
            ),
          ),
        )
    );
  }
  /*
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
  }*/
}
