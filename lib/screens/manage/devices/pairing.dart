import 'package:data/constants/colors.dart';
import 'package:data/services/device_pairing_service.dart';
import 'package:data/utils/form_group_util.dart';
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
  FormGroupUtil connectionFormGroup;
  FormGroupUtil dataFormGroup;

  _DevicePairingScreenState({this.device}) {
    this.connectionFormGroup = FormGroupUtil(
        [
          'wifi_ssid',
          'wifi_password',
          'wifi_security',
          'gateway_url',
        ]);

    this.dataFormGroup = FormGroupUtil(
        [
          'name',
          'description',
          'manufacture_date',
          'serial',
          'type',
        ]);
  }

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
              EntryField(label: "Wifi name", controller: connectionFormGroup.getFormControl('wifi_ssid'),),
              EntryField(label: "Wifi password", controller: connectionFormGroup.getFormControl('wifi_password'), type: EntryFieldType.password),
              EntryField(label: "Gateway server URL", controller: connectionFormGroup.getFormControl('gateway_url'), value: "http://93.188.34.235:8002"),

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

              EntryField(label: "Device name", controller: dataFormGroup.getFormControl("name")),
              EntryField(label: "Device description", controller: dataFormGroup.getFormControl("description")),
              EntryField(label: "Serial number", controller: dataFormGroup.getFormControl("serial")),
              EntryField(label: "Type", controller: dataFormGroup.getFormControl("type")),
              DatePicker("Manufacture date", controller: dataFormGroup.getFormControl("manufacture_date"),  defaultValue: DateTime.now()),
              SizedBox(height: 16),
              Button(
                text: "Set up device",
                textColor: Colors_.enabledPrimary,
                color: Colors_.enabledSecondary,
                onPressed: () async {
                  await DevicePairingService().registerDevice(
                    device: this.device,
                    name: dataFormGroup.getFormControl("name").text,
                    description: dataFormGroup.getFormControl("description").text,
                    serial: dataFormGroup.getFormControl("serial").text,
                );
                  Navigator.of(context).pop();

                  },
              )
            ],
          )
        )
    );
  }
}