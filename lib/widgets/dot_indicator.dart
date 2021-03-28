import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  Color color;
  Size size;

  DotIndicator({@required this.color, this.size = const Size(12, 12)}) {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipOval(
      child: Material(
        color: this.color, // button color
        child: InkWell(
          splashColor: this.color, // inkwell color
          child: SizedBox(width: this.size.width, height: this.size.height),
          onTap: () {},
        ),
      ),
    );
  }
}