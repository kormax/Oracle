import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';

class DevicePairingService {
  static final DevicePairingService _singleton = DevicePairingService._internal();
  // Oracle devices should have a service with following uuid at all times
  static const DEVICE_SYSTEM_SERVICE_UUID = "4FAFC201-1FB5-459E-8FCC-C5C9C331914B";
  static const DEVICE_PAIRING_SERVICE_UUID = "9DE7D5B2-CF0E-41EF-8724-0B69F4EE396F";

  static const DEVICE_CH_IS_SETUP = "BEB5483E-36E1-4688-B7F5-EA07361B26A8";
  static const DEVICE_CH_SYSTEM_ID = "0A3628D-0531-426D-A021-C00515825859";
  static const DEVICE_CH_DEVICE_TYPE = "6226D795-C3B3-4936-B7AD-74EDBEBCDEAC";
  static const DEVICE_CH_SOFTWARE_VERSION = "36C1DF58-26E3-4141-A1EA-1234B375FD55";


  FlutterBlue flutterBlueInstance;

  factory DevicePairingService() => _singleton;

  DevicePairingService._internal() {
    this.flutterBlueInstance = FlutterBlue.instance;
  }

  Stream<ScanResult> startScan() {
    return flutterBlueInstance.scan();
  }

  Future<dynamic> stopScan() {
    return flutterBlueInstance.stopScan();
  }

}