import 'package:data/constants/colors.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
                "assets/logo.svg",
                height: size.height * 0.10,
                width: size.height * 0.10,
                semanticsLabel: 'Logo',
                color: Colors_.primary
            ),
            Text(
              "Welcome screen",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            SizedBox(height: size.height * 0.45),


            Center(
                child: Button(
                  text: "Login",
                  color: Colors_.primaryNormal,
                  textColor: Colors_.grayscaleWhite,
                  onPressed: () => Navigator.pushNamed(context, "/login"),
                )
            ),

            Center(
                child: Button(
                  text: "Signup",
                  color: Colors_.grayscaleWhite,
                  textColor: Colors_.primaryNormal,
                  onPressed: () => Navigator.pushNamed(context, "/signup"),
                )
            ),

            SizedBox(height: size.height * 0.05),

          ],
        ),
      ),
    );
  }
}

