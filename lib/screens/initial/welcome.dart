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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxHeight <= 512) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child:  Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SizedBox(height: 32,),
              Text(
                  "Welcome",
                  style: Text_.heading1
              ),

              SvgPicture.asset(
                  "assets/logo.svg",
                  height: 128,
                  width: 128,
                  semanticsLabel: 'Logo',
                  color: Colors_.primary
              ),




              SizedBox(height: 32,),
              LoginButton(),
              SizedBox(height: 8,),
              SignupButton(),




            ],
          ),
        );
      } else {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 32,),

              Text(
                  "Welcome",
                  style: Text_.heading1
              ),

              Spacer(flex: 1),


              Expanded(
                flex: 3,
                child: SvgPicture.asset(
                  "assets/logo.svg",
                  semanticsLabel: 'Logo',
                  color: Colors_.primary
              ),),

              Spacer(flex: 1),
              LoginButton(),
              SizedBox(height: 8,),
              SignupButton(),


            ],
          ),
        );
      }
    })

    );
  }

  Widget SignupButton() => Button(
    text: "Signup",
    color: Colors_.grayscaleWhite,
    textColor: Colors_.primaryNormal,
    onPressed: () => Navigator.popAndPushNamed(context, "/signup"),
  );

  Widget LoginButton() => Button(
    text: "Login",
    color: Colors_.primaryNormal,
    textColor: Colors_.grayscaleWhite,
    onPressed: () => Navigator.popAndPushNamed(context, "/login"),
  );

}

