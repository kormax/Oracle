import 'package:data/entities/user.dart';

import 'note.dart';

class Task {
  int id;
  int priority;
  int creator_id;
  int assignee_id;
  String name;
  String description;
  String status;
  DateTime due_date;
  DateTime completion_date;
  double grade;
  List<Note> notes;

  Task(this.id, this.priority, this.name, this.description, this.status, this.due_date,
      this.completion_date, this.grade);

  Task.fromJson(Map<String, dynamic> json)
      : priority = json['priority'],
        name = json['name'],
        description = json['description'],
        status = json['status'],
        due_date = DateTime.parse(json['due_date']),
        completion_date = DateTime.parse(json['completion_date']),
        grade = json['grade'];

  Task.taskAddFromJson(Map<String, dynamic> json)
      : priority = int.tryParse(json['priority']),
        name = json['name'],
        description = json['description'],
        status = json['status'],
        due_date = DateTime.parse(json['due_date']),
        completion_date = DateTime.parse(json['completion_date']),
        grade = double.tryParse(json['grade']);

  Map<String, dynamic> taskAddToJson() {
    return {
      "creator_id": creator_id.toString(),
      "name": name.toString(),
      "priority": priority.toString(),
      "due_date": due_date.toString(),
      "completion_date": completion_date.toString(),
      "description": description.toString(),
      "status": status.toString(),
      "grade": grade.toString(),
      "assignee_id": assignee_id.toString()
    };
  }
}
