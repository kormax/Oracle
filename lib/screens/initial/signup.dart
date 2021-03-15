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
    return Scaffold(
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxHeight <= 512 + 128) {
                return SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 32),

                      Text(
                          "Sign up",
                          style: Text_.heading1
                      ),


                      EntryField(label: "Login", type: EntryFieldType.plaintext),
                      EntryField(label: "Email", type: EntryFieldType.plaintext),
                      EntryField(label: "Password", type: EntryFieldType.password),
                      EntryField(label: "Retype password", type: EntryFieldType.password),


                      SizedBox(height: 32),
                      LoginButton(),
                      SizedBox(height: 8),
                      SignupButton(),




                    ],
                  ),
                );
              } else {
                return Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(height: 32,),
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

                        SignupButton(),
                        SizedBox(height: 8,),
                        LoginButton(),
                      ],
                    )
                );
              }
            }
        )
    );
  }

  Widget SignupButton() => Button(
    text: "Signup",
    color: Colors_.primaryNormal,
    textColor: Colors_.grayscaleWhite,
    onPressed: () => Navigator.popAndPushNamed(context, "/main"),
  );

  Widget LoginButton() => Button(
    text: "Or login",
    color: Colors_.grayscaleWhite,
    textColor: Colors_.primaryNormal,
    onPressed: () => Navigator.popAndPushNamed(context, "/login"),
  );

}
