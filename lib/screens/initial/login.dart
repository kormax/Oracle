import 'dart:io';

import 'package:data/constants.dart';
import 'package:data/services/auth_service.dart';
import 'package:data/widgets/button.dart';
import 'package:data/widgets/entry_field.dart';
import 'package:data/widgets/entry_field_type.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxHeight <= 512 - 32) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 32),
              Text("Login", style: Text_.heading1),
              EntryField(label: "Login", type: EntryFieldType.plaintext),
              EntryField(label: "Password", type: EntryFieldType.password),
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
                SizedBox(
                  height: 32,
                ),
                Text("Login", style: Text_.heading1),
                Spacer(),
                EntryField(
                  label: "Login",
                  type: EntryFieldType.plaintext,
                  controller: emailController,
                ),
                EntryField(
                  label: "Password",
                  type: EntryFieldType.password,
                  controller: passwordController,
                ),
                Spacer(),
                LoginButton(),
                SizedBox(
                  height: 8,
                ),
                SignupButton(),
              ],
            ));
      }
    }));
  }

  Widget SignupButton() => Button(
        text: "Or signup",
        color: Colors_.grayscaleWhite,
        textColor: Colors_.primaryNormal,
        onPressed: () => Navigator.popAndPushNamed(context, "/signup"),
      );

  Widget LoginButton() => Button(
        text: "Login",
        color: Colors_.primaryNormal,
        textColor: Colors_.grayscaleWhite,
        onPressed: () {
          AuthService.loginUser(
                  login: emailController.text,
                  password: passwordController.text)
              .then((Response response) {
            if (response.statusCode == HttpStatus.ok) {
              Navigator.popAndPushNamed(context, "/main");
            }

            if (response.statusCode == HttpStatus.unauthorized) {
              print('sdasdf');
            }
          });
        },
      );
}
