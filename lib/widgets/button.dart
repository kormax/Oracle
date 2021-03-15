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
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: MaterialButton(
          elevation: 24,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          color: color,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 16, height: 24/16),
          ),
        ),
      ),
    );
  }
}