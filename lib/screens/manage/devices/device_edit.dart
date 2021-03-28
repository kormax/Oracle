import 'package:data/constants/colors.dart';
import 'package:data/entities/device.dart';
import 'package:data/widgets/button.dart';
import 'package:data/widgets/date_picker.dart';
import 'package:data/widgets/entry_field.dart';
import 'package:data/widgets/entry_field_type.dart';
import 'package:data/widgets/select_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceEditScreen extends StatefulWidget {
  final Device device;
  DeviceEditScreen({this.device});

  @override
  _DeviceEditScreenState createState() => _DeviceEditScreenState(device: this.device);
}

class _DeviceEditScreenState extends State<DeviceEditScreen> {
  final Device device;

  _DeviceEditScreenState({this.device});

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
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[],
          centerTitle: true,
          title: Text("Device edit"),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [


                EntryField(label: "Device name", value: device.name,),
                EntryField(label: "Device description", value: device.description,),
                DatePicker("Manufacture date", defaultValue: device.manufactureDate),
                SizedBox(height: 16),
                Button(
                  text: "Save",
                  textColor: Colors_.enabledPrimary,
                  color: Colors_.enabledSecondary,
                  onPressed: () { print("Se"); },
                )
              ],
            )
        )
    );
  }
}