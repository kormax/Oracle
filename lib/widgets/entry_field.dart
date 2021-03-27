import 'package:data/widgets/entry_field_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:data/constants.dart";

class EntryField extends StatelessWidget {
  final String label;
  final EntryFieldType type;
  final String value;

  var textController = TextEditingController();

  EntryField({@required this.label, this.type = EntryFieldType.plaintext, this.value = '', TextEditingController controller}) {
    if(value != null) {
      textController.text = value;
    }

    if (controller != null) {
      textController = controller;
      textController.text = textController.text.isEmpty ? value : textController.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 48,
            child: TextField(
                controller: textController,
                obscureText: type == EntryFieldType.password,
                decoration: InputDecoration(
                  border:  OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(8.0),
                    ),

                  ),
                  enabledBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(
                        width: 2,
                        color: Colors_.grayscaleNeutral
                    ),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(8.0),
                    ),
                  ),
                  focusedBorder:  OutlineInputBorder(
                    borderSide:  BorderSide(
                        width: 3,
                        color: Colors_.primary
                    ),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(8.0),
                    ),
                  ),

                )
            ),
          )

        ],
      ),
    );
  }
}
