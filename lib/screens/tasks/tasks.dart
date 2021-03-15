import 'package:data/services/task_service.dart';
import 'package:data/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:data/constants.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TaskService taskService;

  @override
  void initState() {
    this.taskService = TaskService();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          child: FutureBuilder(
            future: this.taskService.getTasks(),
            builder: (context, projectSnap) {
              return ListView.builder(
                  itemCount: projectSnap.data.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return TaskWidget(task: projectSnap.data[index]);
                  });
            },
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.add, color: Colors_.grayscaleWhite),
          backgroundColor: Colors_.primaryNormal,
          onPressed: () {}),
    );
  }
}
