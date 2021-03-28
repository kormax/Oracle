import 'package:bloc/bloc.dart';
import 'package:data/bloc_events/tasks.event.dart';
import 'package:data/bloc_state/tasks.state.dart';
import 'package:data/entities/task.dart';
import 'package:data/services/task_service.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TaskService _taskService = TaskService();

  TasksBloc() : super(TasksState.initial());

  void onAddTask(Task task) {
   add(AddTask(task));
  }

  void onDeleteTask(Task task) {
    add(DeleteTask(task));
  }

  void onUpdateTask(Task task) {
    add(UpdateTask(task));
  }

  void onGetAllTasks() {
    print('onGetAllTasks');

    add(GetAllTasks());
  }

  @override
  Stream<TasksState> mapEventToState(TasksEvent event) async* {
    if (event is GetAllTasks) {
      state.tasks = await _taskService.getTasks();
    }

    if (event is AddTask) {
      await _taskService.addTask(event.value);

      onGetAllTasks();
    }

    if (event is DeleteTask) {
      await _taskService.deleteTask(event.value);

      onGetAllTasks();
    }

    yield TasksState(state.tasks);
  }
}