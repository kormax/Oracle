import 'dart:async';

import 'package:data/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SelectField<T> extends StatefulWidget {
  List<T> possibleValues;
  String label;
  SelectField({this.possibleValues, this.label=""});

  @override
  _SelectFieldState<T> createState() => _SelectFieldState<T>(possibleValues: this.possibleValues, label: this.label);
}

class _SelectFieldState<T> extends State<SelectField> {
  List<T> possibleValues;
  Stream<T> selectedValue;
  StreamController<T> controller;
  String label;

  _SelectFieldState({this.possibleValues, this.label = ""}) {
  }

  @override
  void initState(){
    super.initState();
    controller = StreamController<T>();
    selectedValue = controller.stream.asBroadcastStream();
  }

  @override
  void dispose() {
    super.dispose();
    controller.close();
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
              child: StreamBuilder<T>(
        stream: selectedValue,
        initialData: possibleValues.length > 0 ? possibleValues[0] : "",
        builder: (c, snapshot) {
          return InputDecorator(
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
                DropdownButton<T>(
                  isDense: true,
                  value: snapshot.data,
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
                  onChanged: (T newValue) {
                    controller.add(newValue);
                  },
                  items: possibleValues
                      .map<DropdownMenuItem<T>>((T value) {
                    return DropdownMenuItem<T>(
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
          );
        }
    ))]));

    }

}

