import 'package:data/entities/user.dart';

import 'note.dart';

class Task {
  int priority;
  String name;
  String description;
  String status;
  DateTime dueDate;
  DateTime completionDate;
  double grade;
  List<User> assignedUsers;
  List<Note> notes;

  Task(this.priority, this.name, this.description, this.status, this.dueDate,
      this.completionDate, this.grade);

  Task.fromJson(Map<String, dynamic> json)
      : priority = json['priority'],
        name = json['name'],
        description = json['description'],
        status = json['status'],
        dueDate = DateTime.parse(json['dueDate']),
        completionDate = DateTime.parse(json['completionDate']),
        grade = json['grade'];
}
