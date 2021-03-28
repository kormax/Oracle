import 'dart:convert';

import 'package:data/entities/device.dart';
import 'package:data/utils/authenticated_http_client.dart';

import 'api-urls.dart';

class DeviceService {
  static final DeviceService _singleton = DeviceService._internal();
  AuthenticatedHttpClient _httpClient;

  factory DeviceService() => _singleton;

  DeviceService._internal() {
    _httpClient = new AuthenticatedHttpClient();
  }

  Future<Device> getDeviceDataById(String deviceId) async {
    var result = await _httpClient.get(ApiUrls.getDeviceByPublicId(deviceId));
    print("Device data by id");
    print(result);
    dynamic response = jsonDecode(result.body);
    return Device(name: response["name"], description: response["description"], serial: response["serial"], type: response["type"],  manufactureDate: response["manufacture_date"]);
  }

  Future<List<Device>> getAllDevices() async {
    var result = await _httpClient.get(ApiUrls.getDevices());
    dynamic response = jsonDecode(result.body);
    List<Device> results = [];
    for (var r in response) {
      results.add(Device(name: r["name"], description: r["description"], serial: r["serial"], type: r["type"],  manufactureDate: r["manufacture_date"]));
    }
    return results;
  }


}