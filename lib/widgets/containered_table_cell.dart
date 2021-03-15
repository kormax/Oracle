import 'package:flutter/cupertino.dart';

class ContaineredTableCell extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Alignment alignment;

  ContaineredTableCell({@required this.child, this.padding = const EdgeInsets.all(8), this.alignment = Alignment.center});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TableCell(child: Container(
        padding: padding,
        alignment: alignment,
        child: child
    ));
  }
}