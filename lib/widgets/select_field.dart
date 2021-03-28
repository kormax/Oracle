import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SelectField<T> extends StatefulWidget {
  List<T> possibleValues;
  SelectField({this.possibleValues});

  @override
  _SelectFieldState<T> createState() => _SelectFieldState<T>(possibleValues: this.possibleValues);
}

class _SelectFieldState<T> extends State<SelectField> {
  List<T> possibleValues;
  Stream<T> selectedValue;
  StreamController<T> controller;

  _SelectFieldState({this.possibleValues}) {
    controller = StreamController<T>();
    selectedValue = controller.stream;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
        stream: selectedValue,
        initialData: possibleValues.length > 0 ? possibleValues[0] : "",
        builder: (c, snapshot) {
          return  DropdownButton<T>(
            value: snapshot.data,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (T newValue) {
              controller.add(newValue);
            },
            items: possibleValues
                .map<DropdownMenuItem<T>>((T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
          );
        }
    );

    }

}

