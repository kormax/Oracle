import 'package:data/entities/agent.dart';
import 'package:data/services/device_pairing_service.dart';
import 'package:data/widgets/dot_indicator.dart';
import 'package:data/widgets/search_scaffold.dart';
import 'package:flutter/material.dart';
import "package:data/constants.dart";
import 'package:flutter_blue/flutter_blue.dart';

import 'device.dart';






class OracleAgentCard extends StatelessWidget {
  OracleAgent agent;

  OracleAgentCard(this.agent);


  @override
  Widget build(BuildContext context) {
    void _onPressed() {
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  DeviceScreen(agent: this.agent)));
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
  return agent;
}


class DevicesScreen extends StatefulWidget {
  @override
  _DevicesScreenState createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";

  @override
  void initState(){
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
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search(listExample: []));
            },
            icon: Icon(Icons.search),
          )
        ],
        centerTitle: true,
        title: Text('Devices'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                LocalDevicesSection(),
                Divider(height: 8,),
                DeviceSuggestions()

              ],
            ),
          ),


        ],
      ),
    );
  }

}

class DeviceSuggestions extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
              top: 16.0, left: 16.0, right: 16.0),
          width: double.infinity,
          alignment: Alignment.topLeft,
          child: Text("Device suggestions",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  height: 24 / 18
              )
          ),
        ),
      ]
    );
  }
}


class LocalDevicesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothState>(
        stream: FlutterBlue.instance.state,
        initialData: BluetoothState.unknown,
        builder: (c, snapshot) {
          final state = snapshot.data;
          if (state == BluetoothState.on) {
            return LocalDevicesSectionBtEnabled();
          }
          return LocalDevicesSectionBtDisabled();
        }
    );
  }
}

class LocalDevicesSectionBtDisabled extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.bluetooth_disabled_rounded,
            size: 64.0,
            color: Colors_.grayscaleDark,
          ),
          Text(
            'Please turn on bluetooth \n to discover & view local devices',
            style: TextStyle(color: Colors_.grayscaleDarkest,),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class LocalDevicesSectionBtEnabled extends StatefulWidget {
  @override
  _LocalDevicesSectionBtEnabledState createState() => _LocalDevicesSectionBtEnabledState();
}


class _LocalDevicesSectionBtEnabledState extends State<LocalDevicesSectionBtEnabled> {
  DevicePairingService devicePairingService;

  _LocalDevicesSectionBtEnabledState() {
    this.devicePairingService = DevicePairingService();
  }

  @override
  void initState(){
    super.initState();
    FlutterBlue.instance.setLogLevel(LogLevel.warning);
    FlutterBlue.instance.startScan(allowDuplicates: false);
  }

  @override
  void dispose() {
    super.dispose();
    FlutterBlue.instance.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              top: 16.0, left: 16.0, right: 16.0),
          width: double.infinity,
          alignment: Alignment.topLeft,
          child: Text("Devices nearby",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  height: 24 / 18
              )
          ),

        ),
        StreamBuilder<List<OracleAgent>>(
          stream: Stream.periodic(Duration(seconds: 2))
              .asyncMap((_) =>
              FlutterBlue.instance.connectedDevices.then((devices) async {
                List<OracleAgent> filtered = [];
                for (BluetoothDevice device in devices) {
                  var discovered = await device.discoverServices();
                  if (discovered != null && discovered.map(
                          (service) =>
                          service.uuid.toString().toUpperCase()
                  ).contains(
                      DevicePairingService.DEVICE_SYSTEM_SERVICE_UUID)) {
                    try {
                      filtered.add(await loadData(device));
                      print("YESS OUR PAIRED DEVICE ADDED");
                    } catch (e) {
                      print("NOO OUR DEVICE WAS NOT ADDED ${e}");
                      break;
                    }
                    ;
                  }
                }
                return filtered;
              })
          ),
          initialData: [],
          builder: (c, snapshot) =>
              Column(
                children: snapshot.data == null ? [] : snapshot.data
                    .map((d) => OracleAgentCard(d)).toList(),
              ),
        ),
        StreamBuilder<List<OracleAgent>>(
          stream: FlutterBlue.instance.scanResults.asyncMap((scan) async {
            List<OracleAgent> results = [];
            for (ScanResult result in scan) {
              if (result.advertisementData.serviceUuids.length > 0) {
                print(result.advertisementData.serviceUuids);
              }
              if (result.advertisementData.serviceUuids.map((r) =>
                  r.toUpperCase())
                  .contains(
                  DevicePairingService.DEVICE_SYSTEM_SERVICE_UUID)) {
                print("YESS OUR DEVICE ADDING");
                try {
                  results.add(await loadData(result.device));
                  print("YESS OUR DEVICE ADDED");
                } catch (e) {
                  print("NOO OUR DEVICE WAS NOT ADDED ${e}");
                  break;
                }
              }
            }
            return results;
          }),
          initialData: [],
          builder: (c, snapshot) =>
              Column(
                children: snapshot.data == null ? [] : snapshot.data
                    .map((d) => OracleAgentCard(d)).toList(),
              ),
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Center(child:
            Column(children: [

              SizedBox(height: 32,
                  width: 32,
                  child: FittedBox(child: CircularProgressIndicator(
                    backgroundColor: Colors_.primary,))),
              SizedBox(height: 16),
              Text(
                'Looking for devices',
                style: TextStyle(color: Colors_.grayscaleDarkest,),
                textAlign: TextAlign.center,
              ),
            ])
            )
        ),
      ],
    );
  }
}


class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  final List<String> listExample;
  Search({this.listExample});

  List<String> recentList = ["Text 4", "Text 3"];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
      // In the false case
          (element) => element.contains(query),
    ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: (){
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}

