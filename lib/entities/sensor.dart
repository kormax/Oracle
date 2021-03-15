import 'sensor_type.dart';
import 'device.dart';
import 'reading.dart';

class Sensor extends Device {
  SensorType type;
  List<Reading> readings;
  String firmwareInfo;
}