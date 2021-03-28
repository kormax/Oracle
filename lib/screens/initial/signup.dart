import 'dart:convert';
import 'dart:io';

import 'package:data/bloc/token.bloc.dart';
import 'package:data/bloc/user.bloc.dart';
import 'package:data/constants.dart';
import 'package:data/entities/user.dart';
import 'package:data/entities/user_token.dart';
import 'package:data/utils/authenticated_http_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  FormGroupUtil signUpFormGroup =
      new FormGroupUtil(['email', 'password', 'first_name', 'last_name']);

  bool error = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Center(
                child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 32,),
                          Text(
                              "Sign up",
                              style: Text_.heading1
                          ),

                          SizedBox(height: 32,),

                          EntryField(label: "Email", type: EntryFieldType.plaintext, controller: signUpFormGroup.getFormControl('email'), error: error,),
                          EntryField(label: "Password", type: EntryFieldType.password, controller: signUpFormGroup.getFormControl('password'), error: error,),
                          EntryField(label: "First name", type: EntryFieldType.plaintext, controller: signUpFormGroup.getFormControl('first_name'), error: error,),
                          EntryField(label: "Last name", type: EntryFieldType.plaintext, controller: signUpFormGroup.getFormControl('last_name'), error: error,),

                          SizedBox(height: 32,),

                          SignupButton(),
                          SizedBox(height: 8,),
                          LoginButton(),
                        ],
                      ),
                    )
                ),
              );
            }
        )
    );
  }

  Widget SignupButton() {
    return Button(
      text: "Signup",
      color: Colors_.primaryNormal,
      textColor: Colors_.grayscaleWhite,
      onPressed: () {
        Map<String, String> newUser = signUpFormGroup.getFormGroupValue();

        AuthService.registerUser(newUser)
            .then((Response response) {
          if (response.statusCode == HttpStatus.created) {
            AuthService.loginUser(password: newUser['password'], login: newUser['email'])
                .then((value) {
              Map<String, dynamic> encodedResponse = jsonDecode(response.body);

              AuthenticatedHttpClient.token = UserToken.fromJson(encodedResponse);

              context.read<TokenBloc>().onSetToken(UserToken.fromJson(encodedResponse));

              context.read<UserBloc>().onSetUser(User.registerFromJson(encodedResponse));

              Navigator.popAndPushNamed(context, "/main");
            });
          } else {
            Map<String, dynamic> error = jsonDecode(response.body);

            this.error = true;

            error.forEach((key, value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(value.toString().replaceAll(RegExp(r'\[|\]'), '')),
                ),
              );
            });
          }
        });
      },
    );
  }

  Widget LoginButton() => Button(
        text: "Or login",
        color: Colors_.grayscaleWhite,
        textColor: Colors_.primaryNormal,
        onPressed: () => Navigator.popAndPushNamed(context, "/login"),
      );
}
