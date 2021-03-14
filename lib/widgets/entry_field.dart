import 'package:data/widgets/entry_field_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EntryField extends StatelessWidget {
  final String label;
  final EntryFieldType type;
  EntryField({@required this.label, this.type = EntryFieldType.plaintext});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: type == EntryFieldType.password,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(8.0),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
