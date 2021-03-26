import 'dart:io';

import 'package:data/constants.dart';
import 'package:data/entities/user.dart';
import 'package:data/services/auth_service.dart';
import 'package:data/utils/form_group_util.dart';
import 'package:data/widgets/button.dart';
import 'package:data/widgets/entry_field.dart';
import 'package:data/widgets/entry_field_type.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FormGroupUtil signUpFormGroup = new FormGroupUtil(['email', 'password', 'first_name', 'last_name']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxHeight <= 512 + 128 || true) {
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


                      EntryField(label: "Email", type: EntryFieldType.plaintext, controller: signUpFormGroup.getFormControl('email'),),
                      EntryField(label: "Password", type: EntryFieldType.password, controller: signUpFormGroup.getFormControl('password')),
                      EntryField(label: "First name", type: EntryFieldType.plaintext, controller: signUpFormGroup.getFormControl('first_name')),
                      EntryField(label: "Last name", type: EntryFieldType.password, controller: signUpFormGroup.getFormControl('last_name')),


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

                        EntryField(label: "Email", type: EntryFieldType.plaintext, controller: signUpFormGroup.getFormControl('email'),),
                        EntryField(label: "Password", type: EntryFieldType.password, controller: signUpFormGroup.getFormControl('password')),
                        EntryField(label: "First name", type: EntryFieldType.plaintext, controller: signUpFormGroup.getFormControl('first_name')),
                        EntryField(label: "Last name", type: EntryFieldType.password, controller: signUpFormGroup.getFormControl('last_name')),

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
    onPressed: () {
      print(signUpFormGroup.getFormGroupValue());

      AuthService.registerUser(signUpFormGroup.getFormGroupValue())
      .then((Response response) {
        if (response.statusCode == HttpStatus.created) Navigator.popAndPushNamed(context, "/main");
      });
    },
  );

  Widget LoginButton() => Button(
    text: "Or login",
    color: Colors_.grayscaleWhite,
    textColor: Colors_.primaryNormal,
    onPressed: () => Navigator.popAndPushNamed(context, "/login"),
  );

}
