import 'package:data/entities/task.dart';

class TasksState {
  List<Task> tasks;

  TasksState(this.tasks);

  factory TasksState.initial() => TasksState([]);
}