import 'package:data/entities/task.dart';
import 'package:data/services/task_service.dart';
import 'package:flutter/material.dart';


class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TaskService taskService;
  List<Task> tasks;


  @override
  void initState(){
    this.taskService = TaskService();
    this.taskService.getTasks().then((value) {
      this.tasks=value;
      print(value);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
              child: Text("Tasks screen")
          )
        ]
    );
  }
}