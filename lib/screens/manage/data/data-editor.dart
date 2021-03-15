import 'package:data/constants.dart';
import 'package:data/entities/task.dart';
import 'package:data/widgets/button.dart';
import 'package:data/widgets/date_picker.dart';
import 'package:data/widgets/entry_field.dart';
import 'package:data/widgets/entry_field_type.dart';
import 'package:flutter/material.dart';

class DataEditorScreen extends StatefulWidget {
  @override
  _DataEditorScreenState createState() => _DataEditorScreenState();
}

class _DataEditorScreenState extends State<DataEditorScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double margin = size.width * 0.1;

    final dynamic dataToEdit = null;

    return Scaffold(
        appBar: AppBar(
          title: Text(dataToEdit == null ? "Data creation" : "Data editing"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16),

              DatePicker("Date"),
              Divider(height: 32),

              EntryField(
                label: "Sensor id",
                type: EntryFieldType.plaintext,
                value: dataToEdit?.status?.toString(),
              ),

              Divider(height: 32),
              EntryField(
                label: "Type",
                type: EntryFieldType.plaintext,
                value: dataToEdit?.type?.toString(),
              ),
              EntryField(
                label: "Value",
                type: EntryFieldType.integer,
                value: dataToEdit?.value?.toString(),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Button(
                    text: "Save",
                    color: Colors_.primaryNormal,
                    textColor: Colors_.grayscaleWhite,
                    onPressed: () => Navigator.pop(context),
                  )),
              SizedBox(height: margin),
            ],
          ),
        ),
    );
  }
}
