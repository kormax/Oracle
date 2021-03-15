import 'package:data/constants/colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final String datePickerName;

  const DatePicker(this.datePickerName);

  @override
  _DatePickerState createState() => _DatePickerState(this.datePickerName);
}

class _DatePickerState extends State<DatePicker> {
  DateTime date = DateTime.now();

  String datePickerName;

  _DatePickerState(name) {
    datePickerName = name;
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        height: 58,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                  color: Color(0xff353535),
                  fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
