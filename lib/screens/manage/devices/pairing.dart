import 'package:data/constants/colors.dart';
import 'package:data/widgets/button.dart';
import 'package:data/widgets/date_picker.dart';
import 'package:data/widgets/entry_field.dart';
import 'package:data/widgets/entry_field_type.dart';
import 'package:data/widgets/select_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DevicePairingScreen extends StatefulWidget {
  final BluetoothDevice device;
  DevicePairingScreen({this.device});

  @override
  _DevicePairingScreenState createState() => _DevicePairingScreenState(device: this.device);
}

class _DevicePairingScreenState extends State<DevicePairingScreen> {
  final BluetoothDevice device;

  _DevicePairingScreenState({this.device});

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
        title: Text("Device pairing"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [

              Container(
                padding: const EdgeInsets.only(top: 8.0),
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: Text("Connection settings",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors_.grayscaleDark,
                        height: 24 / 18
                    )
                ),

              ),
              EntryField(label: "Wifi name"),
              EntryField(label: "Wifi password", type: EntryFieldType.password),
              SelectField(label: "Wifi security type", possibleValues: ["Auto", "WPA2", "WEP", "WPA", "TKIP"],),
              EntryField(label: "Gateway server URL", value: "http://93.188.34.235:8002"),

              Divider(height: 8,),
              Container(
                padding: const EdgeInsets.only( top: 8.0),
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: Text("Device properties",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors_.grayscaleDark,
                        fontSize: 18.0,
                        height: 24 / 18
                    )
                ),

              ),
              EntryField(label: "Device name"),
              EntryField(label: "Device description"),
              DatePicker("Manufacture date", defaultValue: DateTime.now()),
              SelectField(label: "Device sensor type", possibleValues: ["Temperature & humidity", "Todo :)"],),
              SizedBox(height: 16),
              Button(
                text: "Set up device",
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