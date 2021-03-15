import 'package:data/entities/task.dart';
import 'package:flutter/widgets.dart';

class TaskWidget extends StatelessWidget {
  final Task task;

  const TaskWidget({this.task});

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(this.task.name));
  }
}
