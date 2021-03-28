import 'package:data/constants/colors.dart';
import 'package:data/entities/agent.dart';
import 'package:data/entities/device.dart';
import 'package:data/screens/manage/devices/device_edit.dart';
import 'package:data/screens/manage/devices/pairing.dart';
import 'package:data/services/device_service.dart';
import 'package:data/widgets/button.dart';
import 'package:data/widgets/dot_indicator.dart';
import 'package:data/widgets/select_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceScreen extends StatefulWidget {
  OracleAgent agent;

  DeviceScreen({this.agent});

  @override
  _DeviceScreenState createState() =>
      _DeviceScreenState(agent: this.agent);
}

class _DeviceScreenState extends State<DeviceScreen> {
  OracleAgent agent;
  Future<Device> device_;

  _DeviceScreenState({this.agent}) {
    print("Device screen state ${agent.deviceId}");
    if (agent.deviceId != null && agent.deviceId.length > 0) {
      print("Device id not null");
      print("Searching");
      this.device_ = DeviceService().getDeviceDataById(agent.deviceId);
    }
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
    return FutureBuilder<Device>(
    future: device_,
      builder: (BuildContext context, AsyncSnapshot<Device> snapshot) {
       Device device = snapshot.data;
       return  Scaffold(
           appBar: AppBar(
             actions: device == null ? [] : [
               IconButton(
                 icon: const Icon(Icons.edit),
                 tooltip: 'Edit',
                 onPressed: () => Navigator.of(context).push(
                     MaterialPageRoute(
                       builder: (context) =>
                           DeviceEditScreen(device: device),
                     )
                 ),
               ),
             ],
             centerTitle: true,
             title: Builder(builder: (context) {
               if (agent != null) {
                 return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                   Text(device != null ? device.name : agent.name),
                   StreamBuilder<BluetoothDeviceState>(
                     stream: agent.device.state,
                     initialData: BluetoothDeviceState.disconnected,
                     builder: (c, snapshot) {
                       List<Widget> result = [SizedBox(width: 8)];
                       if (snapshot.data == BluetoothDeviceState.connected) {
                         result.add(DotIndicator(color: Colors_.successPrimary));
                       } else if (snapshot.data ==
                           BluetoothDeviceState.disconnected) {
                         result.add(DotIndicator(color: Colors_.errorPrimary));
                       } else {
                         result.add(DotIndicator(color: Colors_.warningPrimary));
                       }
                       return Row(children: result);
                     },
                   ),
                 ]);
               } else {
                 return Text(device.name);
               }
             }),
           ),
           body: SingleChildScrollView(
               padding: EdgeInsets.all(16),
               child: Column(
                 children: [
                   Builder(builder: (context) {
                     return agent == null
                         ? SizedBox.shrink()
                         : StreamBuilder<BluetoothDeviceState>(
                         stream: agent.device.state,
                         initialData: BluetoothDeviceState.disconnected,
                         builder: (c, snapshot) {
                           return Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               Container(
                                   width: double.infinity,
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.all(
                                           Radius.circular(16.0))),
                                   child: Container(
                                       alignment: Alignment.topLeft,

                                       decoration: BoxDecoration(
                                           color: Colors_.grayscaleWhite,
                                           borderRadius: BorderRadius.all(
                                               Radius.circular(8.0)),
                                           boxShadow: [BoxShadow(color: Colors_.grayscaleBlack)]
                                       ),
                                       padding: EdgeInsets.all(16),
                                       child: Column(
                                         crossAxisAlignment:
                                         CrossAxisAlignment.start,
                                         children: [
                                           Text("Name: ${agent.name}"),
                                           Text(
                                               "Device type: ${agent.deviceType}"),
                                           Text(
                                               "Software version: ${agent.softwareVersion}"),
                                         ],
                                       ))),
                               SizedBox(
                                 height: 16,
                               ),
                               Button(
                                 text: agent.isPaired ? "Already paired" : "Pair",
                                 textColor: Colors_.enabledPrimary,
                                 color: Colors_.enabledSecondary,
                                 onPressed: () => snapshot.data ==
                                     BluetoothDeviceState.disconnected || agent.isPaired
                                     ? null
                                     : Navigator.of(context).push(
                                     MaterialPageRoute(
                                         builder: (context) =>
                                             DevicePairingScreen(
                                                 device: agent.device))),
                               ),


                             ],
                           );
                         });
                   }),
                   Builder(builder: (context) {
                     return device == null
                         ? SizedBox.shrink()
                         : Column(
                       children: [
                         Text("Name: ${device.name}"),
                         Text(
                             "Description: ${device.description}"),
                         Text(
                             "Manufacture date: ${device.manufactureDate}"),
                         Text(
                             "Model number: ${device.modelNumber}"),
                       ],
                     );

                   }),
                 ],
               )));
    });

  }
}
