import 'dart:convert';
import 'dart:io';

import 'package:data/constants.dart';
import 'package:data/services/auth_service.dart';
import 'package:data/utils/form_group_util.dart';
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
  FormGroupUtil loginFormGroup = new FormGroupUtil(['email', 'password']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Center(
        child: SingleChildScrollView(
          child: Container(
            height: constraints.maxHeight,
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                SizedBox(height: 32),
                Text("Login", style: Text_.heading1),
                Spacer(),
                EntryField(label: "Login", type: EntryFieldType.plaintext, controller: loginFormGroup.getFormControl('email'),),
                EntryField(label: "Password", type: EntryFieldType.password, controller: loginFormGroup.getFormControl('password'),),
                Spacer(),
                LoginButton(),
                SizedBox(height: 8),
                SignupButton(),
              ],
            ),
          )
        ),
      );
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
          Map<String, String> fromData = loginFormGroup.getFormGroupValue();

          AuthService.loginUser(
                  login: fromData['email'], password: fromData['password'])
              .then((Response response) {
            if (response.statusCode == HttpStatus.ok) {
              Navigator.popAndPushNamed(context, "/main");
            } else {
              Map<String, dynamic> error = jsonDecode(response.body);

              error.forEach((key, value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(value.toString()),
                  ),
                );
              });
            }
          });
        },
      );
}
