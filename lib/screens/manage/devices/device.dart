import 'package:data/constants/colors.dart';
import 'package:data/entities/agent.dart';
import 'package:data/widgets/dot_indicator.dart';
import 'package:data/widgets/select_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceScreen extends StatefulWidget {
  OracleAgent agent;

  DeviceScreen({this.agent});

  @override
  _DeviceScreenState createState() => _DeviceScreenState(agent: this.agent);
}

class _DeviceScreenState extends State<DeviceScreen> {
  OracleAgent agent;

  _DeviceScreenState({this.agent});

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
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(agent.name),
          SizedBox(width: 8),
          StreamBuilder<BluetoothDeviceState>(
            stream: agent.device.state,
            initialData: BluetoothDeviceState.disconnected,
            builder: (c, snapshot) {
              if (snapshot.data ==
                  BluetoothDeviceState.connected) {
                return DotIndicator(color: Colors_.successPrimary);
              } else if (snapshot.data ==
                  BluetoothDeviceState.disconnected) {
                return DotIndicator(color: Colors_.errorPrimary);
              }
              return DotIndicator(color: Colors_.warningPrimary);
            },
          ),
        ])
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Card(
                child: Column(
                  children: [
                    Text("Name: ${agent.name}"),
                    Text("Device type: ${agent.deviceType}"),
                    Text("Software version: ${agent.softwareVersion}"),
                  ],
                )
              )
            ),

            SelectField(possibleValues: ["Temperature", "Humidity", "Temperature & humridity"],)
          ],
        )
      ),
    );
  }
}