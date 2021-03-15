import 'reading.dart';
import 'sensor.dart';
import 'device.dart';

class Meter extends Device {
  List<Sensor> sensors;
  List<Reading> readings;
}