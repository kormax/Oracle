import 'dart:async';
import 'dart:math';

import 'package:data/constants.dart';
import 'package:data/services/device_pairing_service.dart';
import 'package:data/widgets/dot_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';


class OracleAgent {
  BluetoothDevice device;
  bool isPaired;
  String deviceId;
  String name;

  String softwareVersion;
  String deviceType;

  OracleAgent({this.isPaired = false, this.name="", this.deviceId = "",
    this.softwareVersion = "", this.deviceType="", this.device=null});
}




class OracleAgentCard extends StatelessWidget {
  OracleAgent agent;

  OracleAgentCard(this.agent) {}


  @override
  Widget build(BuildContext context) {
    void _onPressed() {
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  DeviceScreen(device: agent.device)));
    }

    return GestureDetector(
        onTap: _onPressed,

        child: Card(
          margin: EdgeInsets.only(left: 16, top: 16, right: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Row(children: [
                Text(this.agent.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        height: 24/18
                    )
                ),
                Spacer(),
                Text(this.agent.isPaired ? "Paired" : "Not paired",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14.0,
                        height: 24/14
                    )
                ),
                SizedBox(width: 6),
                Align(
                  alignment: Alignment.center,
                  child: StreamBuilder<BluetoothDeviceState>(
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
                )

              ]),
            ),

            Divider(height: 8,),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(children: [
                Text("Type: ${this.agent.deviceType}"),
                Spacer(),
                Text("Software version: ${this.agent.softwareVersion}"),
              ]),

            )
          ]),
        ));
  }
}



Future<OracleAgent> loadData(BluetoothDevice device) async {
  //print("GETTING DEVICE");
  await device.connect();
  await device.discoverServices();

  List<BluetoothService> services = await device.discoverServices();
  //print("Got services ${services}");

  var agent = OracleAgent(name: device.name);

  for (var service in services) {
    if (service.uuid.toString().toUpperCase() == DevicePairingService.DEVICE_SYSTEM_SERVICE_UUID) {
      for (var characteristic in service.characteristics) {

        switch(characteristic.uuid.toString().toUpperCase()) {
          case DevicePairingService.DEVICE_CH_IS_SETUP:
            var chars = await characteristic.read();
            agent.isPaired = chars.length == 0 ? false : chars[0];
          break;
          case DevicePairingService.DEVICE_CH_SYSTEM_ID:
            agent.deviceId = String.fromCharCodes(await characteristic.read());
          break;
          case DevicePairingService.DEVICE_CH_SOFTWARE_VERSION:
            agent.softwareVersion = String.fromCharCodes(await characteristic.read());
          break;
          case DevicePairingService.DEVICE_CH_DEVICE_TYPE:
            agent.deviceType = String.fromCharCodes(await characteristic.read());
          break;
          default: { }
          break;
          }
      }
    }
  }

  agent.device = device;
  //print("GOT DEVICE");

  return agent;
}



class ScanResultTile extends StatelessWidget {
  const ScanResultTile({Key key, @required this.result, this.onTap})
      : super(key: key);

  final ScanResult result;
  final VoidCallback onTap;

  Widget _buildTitle(BuildContext context) {
    if (result.device.name.length > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            result.device.name,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            result.device.id.toString(),
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
    } else {
      return Text(result.device.id.toString());
    }
  }

  Widget _buildAdvRow(BuildContext context, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.caption),
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.apply(color: Colors.black),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  String getNiceHexArray(List<int> bytes) {
    return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]'
        .toUpperCase();
  }

  String getNiceManufacturerData(Map<int, List<int>> data) {
    if (data.isEmpty) {
      return 'N/A';
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add(
          '${id.toRadixString(16).toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  String getNiceServiceData(Map<String, List<int>> data) {
    if (data.isEmpty) {
      return 'N/A';
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add('${id.toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: _buildTitle(context),
      leading: Text(result.rssi.toString()),
      trailing: RaisedButton(
        child: Text('CONNECT'),
        color: Colors.black,
        textColor: Colors.white,
        onPressed: (result.advertisementData.connectable) ? onTap : null,
      ),
      children: <Widget>[
        _buildAdvRow(
            context, 'Complete Local Name', result.advertisementData.localName),
        _buildAdvRow(context, 'Tx Power Level',
            '${result.advertisementData.txPowerLevel ?? 'N/A'}'),
        _buildAdvRow(context, 'Manufacturer Data',
            getNiceManufacturerData(result.advertisementData.manufacturerData)),
        _buildAdvRow(
            context,
            'Service UUIDs',
            (result.advertisementData.serviceUuids.isNotEmpty)
                ? result.advertisementData.serviceUuids.join(', ').toUpperCase()
                : 'N/A'),
        _buildAdvRow(context, 'Service Data',
            getNiceServiceData(result.advertisementData.serviceData)),
      ],
    );
  }
}

class ServiceTile extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile> characteristicTiles;

  const ServiceTile(
      {Key key, @required this.service, @required this.characteristicTiles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (characteristicTiles.length > 0) {
      return ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Service'),
            Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}',
                style: Theme.of(context).textTheme.body1?.copyWith(
                    color: Theme.of(context).textTheme.caption?.color))
          ],
        ),
        children: characteristicTiles,
      );
    } else {
      return ListTile(
        title: Text('Service'),
        subtitle:
        Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}'),
      );
    }
  }
}

class CharacteristicTile extends StatelessWidget {
  final BluetoothCharacteristic characteristic;
  final List<DescriptorTile> descriptorTiles;
  final VoidCallback onReadPressed;
  final VoidCallback onWritePressed;
  final VoidCallback onNotificationPressed;

  const CharacteristicTile(
      {Key key,
        @required this.characteristic,
        @required this.descriptorTiles,
        this.onReadPressed,
        this.onWritePressed,
        this.onNotificationPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
      stream: characteristic.value,
      initialData: characteristic.lastValue,
      builder: (c, snapshot) {
        final value = snapshot.data;
        return ExpansionTile(
          title: ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Characteristic'),
                Text(
                    '0x${characteristic.uuid.toString().toUpperCase().substring(4, 8)}',
                    style: Theme.of(context).textTheme.body1?.copyWith(
                        color: Theme.of(context).textTheme.caption?.color))
              ],
            ),
            subtitle: Text(value.toString()),
            contentPadding: EdgeInsets.all(0.0),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.file_download,
                  color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
                ),
                onPressed: onReadPressed,
              ),
              IconButton(
                icon: Icon(Icons.file_upload,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                onPressed: onWritePressed,
              ),
              IconButton(
                icon: Icon(
                    characteristic.isNotifying
                        ? Icons.sync_disabled
                        : Icons.sync,
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                onPressed: onNotificationPressed,
              )
            ],
          ),
          children: descriptorTiles,
        );
      },
    );
  }
}

class DescriptorTile extends StatelessWidget {
  final BluetoothDescriptor descriptor;
  final VoidCallback onReadPressed;
  final VoidCallback onWritePressed;

  const DescriptorTile(
      {Key key,
        @required this.descriptor,
        this.onReadPressed,
        this.onWritePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Descriptor'),
          Text('0x${descriptor.uuid.toString().toUpperCase().substring(4, 8)}',
              style: Theme.of(context)
                  .textTheme
                  .body1
                  ?.copyWith(color: Theme.of(context).textTheme.caption?.color))
        ],
      ),
      subtitle: StreamBuilder<List<int>>(
        stream: descriptor.value,
        initialData: descriptor.lastValue,
        builder: (c, snapshot) => Text(snapshot.data.toString()),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.file_download,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
            ),
            onPressed: onReadPressed,
          ),
          IconButton(
            icon: Icon(
              Icons.file_upload,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
            ),
            onPressed: onWritePressed,
          )
        ],
      ),
    );
  }
}

class AdapterStateTile extends StatelessWidget {
  const AdapterStateTile({Key key, @required this.state}) : super(key: key);

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: ListTile(
        title: Text(
          'Bluetooth adapter is ${state.toString().substring(15)}',
          style: Theme.of(context).primaryTextTheme.subhead,
        ),
        trailing: Icon(
          Icons.error,
          color: Theme.of(context).primaryTextTheme.subhead?.color,
        ),
      ),
    );
  }
}



class BluetoothDisabledScreen extends StatelessWidget {
  const BluetoothDisabledScreen({Key key, this.state}) : super(key: key);

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors_.grayscaleWhite,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled_rounded,
              size: 200.0,
              color: Colors_.grayscaleDark,
            ),
            Text(
              'Please turn on bluetooth \n to continue pairing process',
              style: TextStyle(color: Colors_.grayscaleDarkest,),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 96,),
          ],
        ),
      ),
    );
  }
}


class PairingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device pairing'),
      ),
      body: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return DeviceSearchScreen();
            }
            return BluetoothDisabledScreen(state: state);
          }),
      );

  }
}

class DeviceSearchScreen extends StatefulWidget {
  @override
  _DeviceSearchScreenState createState() => _DeviceSearchScreenState();
}


class _DeviceSearchScreenState extends State<DeviceSearchScreen> {
  DevicePairingService devicePairingService;

  _DeviceSearchScreenState() {
    this.devicePairingService = DevicePairingService();
  }

  @override
  void initState(){
    super.initState();
    FlutterBlue.instance.startScan();
  }

  @override
  void dispose() {
    super.dispose();
    FlutterBlue.instance.stopScan();
  }

  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () { print("On refresh"); return Future<void>((){}); },
      //    FlutterBlue.instance.startScan(timeout: Duration(seconds: 4)),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<List<OracleAgent>>(
              stream: Stream.periodic(Duration(seconds: 2))
                  .asyncMap((_) =>
                 FlutterBlue.instance.connectedDevices.then((devices) async {
                  List<OracleAgent> filtered = [];
                  for (BluetoothDevice device in devices) {
                    var discovered = await device.discoverServices();
                    if (discovered != null && discovered.map(
                            (service) => service.uuid.toString().toUpperCase()
                    ).contains(DevicePairingService.DEVICE_SYSTEM_SERVICE_UUID)) {
                      filtered.add(await loadData(device));
                    }
                  }
                  return filtered;
                })
              ),
              initialData: [],
              builder: (c, snapshot) => Column(
                children: snapshot.data == null ? [] : snapshot.data
                    .map((d) => OracleAgentCard(d)/*ListTile(
                  title: Text(d.device.name),
                  subtitle: Text(d.device.id.toString()),
                  trailing: StreamBuilder<BluetoothDeviceState>(
                    stream: d.device.state,
                    initialData: BluetoothDeviceState.disconnected,
                    builder: (c, snapshot) {
                      if (snapshot.data ==
                          BluetoothDeviceState.connected) {
                        return RaisedButton(
                          child: Text('OPEN'),
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DeviceScreen(device: d.device))),
                        );
                      }
                      return Text(snapshot.data.toString());
                    },
                  ),
                )*/).toList(),
              ),
            ),
            StreamBuilder<List<OracleAgent>>(
              stream: FlutterBlue.instance.scanResults.asyncMap((scan) async {
                List<OracleAgent> results = [];
                for (ScanResult result in scan) {
                  print(result.advertisementData.serviceUuids.map((r) => r.toUpperCase()));
                  if (result.advertisementData.serviceUuids.map((r) => r.toUpperCase())
                      .contains(DevicePairingService.DEVICE_SYSTEM_SERVICE_UUID)) {
                    print("YESS OUR DEVICE");
                    results.add(await loadData(result.device));
                  }
                }
                return results;
              }),
              initialData: [],
              builder: (c, snapshot) => Column(
                children: snapshot.data == null ? [] : snapshot.data
                    .map((d) => OracleAgentCard(d)/*ListTile(
                  title: Text(d.device.name),
                  subtitle: Text(d.device.id.toString()),
                  trailing: StreamBuilder<BluetoothDeviceState>(
                    stream: d.device.state,
                    initialData: BluetoothDeviceState.disconnected,
                    builder: (c, snapshot) {
                      if (snapshot.data ==
                          BluetoothDeviceState.connected) {
                        return RaisedButton(
                          child: Text('OPEN'),
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DeviceScreen(device: d.device))),
                        );
                      }
                      return Text(snapshot.data.toString());
                    },
                  ),
                )*/).toList(),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                child: Center(child:
                Column(children: [

                  SizedBox(height:32, width: 32, child: FittedBox(child: CircularProgressIndicator(backgroundColor: Colors_.primary,))),
                  SizedBox(height:16),
                  Text(
                    'Looking for devices',
                    style: TextStyle(color: Colors_.grayscaleDarkest,),
                    textAlign: TextAlign.center,
                  ),
                ])
                )
            ),
          ],
        ),
      ),
    );
  }
}

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key key, @required this.device}) : super(key: key);

  final BluetoothDevice device;

  List<int> _getRandomBytes() {
    final math = Random();
    return [
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255)
    ];
  }

  List<Widget> _buildServiceTiles(List<BluetoothService> services) {
    return services
        .map(
          (s) => ServiceTile(
        service: s,
        characteristicTiles: s.characteristics
            .map(
              (c) => CharacteristicTile(
            characteristic: c,
            onReadPressed: () => c.read(),
            onWritePressed: () async {
              await c.write(_getRandomBytes(), withoutResponse: true);
              await c.read();
            },
            onNotificationPressed: () async {
              await c.setNotifyValue(!c.isNotifying);
              await c.read();
            },
            descriptorTiles: c.descriptors
                .map(
                  (d) => DescriptorTile(
                descriptor: d,
                onReadPressed: () => d.read(),
                onWritePressed: () => d.write(_getRandomBytes()),
              ),
            )
                .toList(),
          ),
        )
            .toList(),
      ),
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => device.disconnect();
                  text = 'DISCONNECT';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () => device.connect();
                  text = 'CONNECT';
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return FlatButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .button
                        ?.copyWith(color: Colors.white),
                  ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? Icon(Icons.bluetooth_connected)
                    : Icon(Icons.bluetooth_disabled),
                title: Text(
                    'Device is ${snapshot.data.toString().split('.')[1]}.'),
                subtitle: Text('${device.id}'),
                trailing: StreamBuilder<bool>(
                  stream: device.isDiscoveringServices,
                  initialData: false,
                  builder: (c, snapshot) => IndexedStack(
                    index: snapshot.data ? 1 : 0,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () => device.discoverServices(),
                      ),
                      IconButton(
                        icon: SizedBox(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.grey),
                          ),
                          width: 18.0,
                          height: 18.0,
                        ),
                        onPressed: null,
                      )
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<int>(
              stream: device.mtu,
              initialData: 0,
              builder: (c, snapshot) => ListTile(
                title: Text('MTU Size'),
                subtitle: Text('${snapshot.data} bytes'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => device.requestMtu(223),
                ),
              ),
            ),
            StreamBuilder<List<BluetoothService>>(
              stream: device.services,
              initialData: [],
              builder: (c, snapshot) {
                return Column(
                  children: _buildServiceTiles(snapshot.data),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}