import 'dart:async';
import 'dart:collection';

import 'package:flutter_blue/flutter_blue.dart';

class TodayService {
  static final TodayService _singleton = TodayService._internal();


  FlutterBlue flutterBlueInstance;

  factory TodayService() => _singleton;

  TodayService._internal() {}

  Future<List<dynamic>> getStatusCards() {
    return Future(() => []); //flutterBlueInstance.scan();
  }

  Future<HashMap<String, num>> getNextWeekTasks() {
    return Future(() => HashMap.from({"3": 1}));
  }

}