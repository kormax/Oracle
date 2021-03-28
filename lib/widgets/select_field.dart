import 'dart:async';

import 'package:data/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SelectField extends StatefulWidget {
  TextEditingController controller;
  List<String> possibleValues;
  String label;
  SelectField({this.controller, this.possibleValues, this.label=""});

  @override
  _SelectFieldState createState() => _SelectFieldState(controller: this.controller, possibleValues: this.possibleValues, label: this.label);
}

class _SelectFieldState extends State<SelectField> {
  TextEditingController controller;
  List<String> possibleValues;
  String label;

  _SelectFieldState({TextEditingController controller, this.possibleValues, this.label = ""}) {
    if (controller == null) {
      this.controller = TextEditingController();
    }
    this.controller.text = this.possibleValues.length > 0 ? this.possibleValues[0] : "";
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 48,
              child: InputDecorator(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(8.0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(width: 2, color: Colors_.grayscaleNeutral),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(8.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Colors_.primary),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(8.0),
                ),
              ),
            ),
            
            child: DropdownButtonHideUnderline( child:
                DropdownButton<String>(
                  isDense: true,
                  value: controller.text,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 16,
                  elevation: 16,
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors_.grayscaleDarkest,
                    fontWeight: FontWeight.normal,
                  ),
                  underline: Container(
                    height: 2,
                    color: Colors.transparent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      controller.text = newValue.toString();
                    });

                  },
                  items: possibleValues
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value.toString(),
                        style: TextStyle(
                        fontSize: 16,
                        color: Colors_.grayscaleDarkest,
                        fontWeight: FontWeight.bold,
                      ),),
                    );
                  }).toList(),
                )
            ),
          )
    )]));

    }

}

