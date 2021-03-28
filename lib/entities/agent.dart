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
