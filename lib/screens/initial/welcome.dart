import 'package:data/constants.dart';
import 'package:data/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
                "assets/logo.svg",
                height: size.height * 0.10,
                width: size.height * 0.10,
                semanticsLabel: 'Logo',
                color: Colors_.primary
            ),
            Text(
              "Welcome",
              style: Text_.heading1
            ),

            Spacer(),


            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 8),
              width: size.width * 0.8,
              child: Button(
              text: "Login",
              color: Colors_.primaryNormal,
              textColor: Colors_.grayscaleWhite,
              onPressed: () => Navigator.popAndPushNamed(context, "/login"),
              )
            ),


            Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.1,  vertical: 8),
                width: size.width * 0.8,
                child: Button(
                  text: "Signup",
                  color: Colors_.grayscaleWhite,
                  textColor: Colors_.primaryNormal,
                  onPressed: () => Navigator.popAndPushNamed(context, "/signup"),
                )
            ),

            SizedBox(height: size.width * 0.1 - 8)


          ],
        ),
      ),
      )
    );
  }
}

