import 'package:data/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class DatePicker extends StatefulWidget {
  final String datePickerName;
  final DateTime defaultValue;

  TextEditingController dateController;

  DatePicker(this.datePickerName, {TextEditingController controller, this.defaultValue}) {
    dateController = controller;
  }

  @override
  _DatePickerState createState() => _DatePickerState(this.datePickerName, controller: dateController, date: defaultValue);
}

class _DatePickerState extends State<DatePicker> {
  DateTime date = DateTime.now();

  String datePickerName;
  TextEditingController dateController;

  _DatePickerState(name, {TextEditingController controller, this.date}) {
    if (controller == null) {
      controller = TextEditingController();
    }
    datePickerName = name;
    controller.text = date.toIso8601String();
    dateController = controller;
  }

  Future _selectDate(BuildContext context) async {
    DateTime picker = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());

    if (picker != null) {
      setState(() {
        date = picker;

        dateController.text = date.toIso8601String();
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.datePickerName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          height: 8,
        ),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
                border: new Border.all(color: Colors_.grayscaleNeutral, width: 2),
                borderRadius: BorderRadius.circular(8.0)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  this.datePickerName ?? 'Date picker',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  new DateFormat('d MMM y').format(date),
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors_.grayscaleDarkest,
                      fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        )
      ]);
  }
}
