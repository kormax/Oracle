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
                    "Login",
                    style: Text_.heading1
                ),

                Spacer(),

                EntryField(label: "Login", type: EntryFieldType.plaintext),
                EntryField(label: "Password", type: EntryFieldType.password),

                Spacer(),

                Container(
                    margin: EdgeInsets.symmetric(horizontal: margin, vertical: 16),
                    width: size.width - margin * 2,
                    child: Button(
                      text: "Login",
                      color: Colors_.primaryNormal,
                      textColor: Colors_.grayscaleWhite,
                      onPressed: () => Navigator.popAndPushNamed(context, "/main"),
                    )
                ),

                Container(
                    margin: EdgeInsets.symmetric(horizontal: margin),
                    width: size.width - margin * 2,
                    child: Button(
                      text: "Or signup",
                      color: Colors_.grayscaleWhite,
                      textColor: Colors_.primaryNormal,
                      onPressed: () => Navigator.popAndPushNamed(context, "/signup"),
                    )
                ),

                SizedBox(height: margin),
              ],
            ),
          ),
        )
    );
  }
}
