import 'package:data/entities/sensor_type.dart';

class Device {
  String name;
  String description;
  String serial;
  String type;
  String modelNumber;
  DateTime manufactureDate;


  Device({
    this.name,
    this.description,
    this.serial,
    this.type,
    this.modelNumber,
    this.manufactureDate
});

}

