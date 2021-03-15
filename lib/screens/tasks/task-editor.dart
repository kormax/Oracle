import 'package:data/constants.dart';
import 'package:data/entities/task.dart';
import 'package:data/widgets/button.dart';
import 'package:data/widgets/date_picker.dart';
import 'package:data/widgets/entry_field.dart';
import 'package:data/widgets/entry_field_type.dart';
import 'package:flutter/material.dart';

class TaskEditorScreen extends StatefulWidget {
  @override
  _TaskEditorScreenState createState() => _TaskEditorScreenState();
}

class _TaskEditorScreenState extends State<TaskEditorScreen> {
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

    final Task taskToEdit = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text(taskToEdit == null ? "Task creation" : "Task editing"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16),
              EntryField(
                label: "Name",
                type: EntryFieldType.plaintext,
                value: taskToEdit?.name?.toString(),
              ),
              EntryField(
                label: "Description",
                type: EntryFieldType.plaintext,
                value: taskToEdit?.description?.toString(),
              ),
              Divider(height: 32),
              EntryField(
                label: "Priority",
                type: EntryFieldType.integer,
                value: taskToEdit?.priority?.toString(),
              ),
              EntryField(
                label: "Status",
                type: EntryFieldType.plaintext,
                value: taskToEdit?.status?.toString(),
              ),
              Divider(height: 32),
              DatePicker("Due date"),
              SizedBox(height: 16),
              DatePicker("Completion date"),
              Divider(height: 32),
              SizedBox(height: 16),
              EntryField(
                label: "Grade",
                type: EntryFieldType.integer,
                value: taskToEdit?.grade?.toString(),
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
        ));
  }
}
