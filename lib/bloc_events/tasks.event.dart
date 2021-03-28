import 'package:data/entities/task.dart';

abstract class TasksEvent {
  Task value;

  TasksEvent({this.value});
}

class GetAllTasks extends TasksEvent {
  GetAllTasks() : super();
}

class AddTask extends TasksEvent {
  AddTask(Task value) : super(value: value);
}

class UpdateTask extends TasksEvent {
  UpdateTask(Task value) : super(value: value);
}

class DeleteTask extends TasksEvent {
  DeleteTask(Task value) : super(value: value);
}