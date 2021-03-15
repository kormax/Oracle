import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import "package:data/constants.dart";

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color, textColor;
  const Button({
    Key key,
    this.text,
    this.onPressed,
    this.color = Colors_.primary,
    this.textColor = Colors_.grayscaleWhite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: MaterialButton(
          elevation: 50,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}