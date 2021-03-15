import 'dart:convert';

import 'package:data/entities/task.dart';

String rawData = r'[{"priority": 1, "name": "name1", "description": "description1", "status": "status1", "dueDate": "2021-03-15T13:01:48.490179", "completionDate": "2021-03-16T13:01:48.490179", "grade": 1.5}, {"priority": 2, "name": "name2", "description": "description2", "status": "status2", "dueDate": "2021-03-15T13:01:48.490179", "completionDate": "2021-03-16T13:01:48.490179", "grade": 2.5}, {"priority": 3, "name": "name3", "description": "description3", "status": "status3", "dueDate": "2021-03-15T13:01:48.490179", "completionDate": "2021-03-16T13:01:48.490179", "grade": 3.5}, {"priority": 4, "name": "name4", "description": "description4", "status": "status4", "dueDate": "2021-03-15T13:01:48.490179", "completionDate": "2021-03-16T13:01:48.490179", "grade": 4.5}, {"priority": 5, "name": "name5", "description": "description5", "status": "status5", "dueDate": "2021-03-15T13:01:48.490179", "completionDate": "2021-03-16T13:01:48.490179", "grade": 5.5}, {"priority": 6, "name": "name6", "description": "description6", "status": "status6", "dueDate": "2021-03-15T13:01:48.490179", "completionDate": "2021-03-16T13:01:48.490179", "grade": 6.5}, {"priority": 7, "name": "name7", "description": "description7", "status": "status7", "dueDate": "2021-03-15T13:01:48.490179", "completionDate": "2021-03-16T13:01:48.490179", "grade": 7.5}, {"priority": 8, "name": "name8", "description": "description8", "status": "status8", "dueDate": "2021-03-15T13:01:48.490179", "completionDate": "2021-03-16T13:01:48.490179", "grade": 8.5}, {"priority": 9, "name": "name9", "description": "description9", "status": "status9", "dueDate": "2021-03-15T13:01:48.490179", "completionDate": "2021-03-16T13:01:48.490179", "grade": 9.5}]';

class TaskService {
  Future<List<Task>> getTasks() {
    Iterable taskDataList = json.decode(rawData);
    List<Task> tasks = List<Task>.from(
        taskDataList.map((model) => Task.fromJson(model)));
    return Future.value(tasks);
  }
}