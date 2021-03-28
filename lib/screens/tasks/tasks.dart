import 'package:data/bloc/tasks.bloc.dart';
import 'package:data/bloc_state/tasks.state.dart';
import 'package:data/services/task_service.dart';
import 'package:data/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:data/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

  @override
  void initState() {
    context.read<TasksBloc>().onGetAllTasks();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            if (state?.tasks?.isEmpty) {
              return Container(
                child: Text('Loading'),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.only(bottom: 16),
              itemCount: state?.tasks?.length ?? 0,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Dismissible(
                    key: Key(state.tasks[index].name),
                    onDismissed: (direction) {
                      setState(() {
                        context.read<TasksBloc>().onDeleteTask(state.tasks[index]);

                        state.tasks.removeAt(index);
                      });
                    },
                    child: TaskWidget(
                      task: state.tasks[index],
                    ));
              },
            );
          },
        ),

        /*child: FutureBuilder(
          future: this.taskService.getTasks(),
          builder: (context, projectSnap) {
            if (projectSnap.data == null) {
              return Container(
                child: Text('Loading'),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.only(bottom: 16),
              itemCount: projectSnap.data.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Dismissible(
                    key: Key(projectSnap.data[index].name),
                    onDismissed: (direction) {
                      setState(() {
                        projectSnap.data.removeAt(index);
                      });
                    },
                    child: TaskWidget(
                      task: projectSnap.data[index],
                    ));
              },
            );
          },
        ),*/
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.add, color: Colors_.grayscaleWhite),
          backgroundColor: Colors_.primaryNormal,
          onPressed: () {
            Navigator.pushNamed(context, "/task/edit");
          }),
    );
  }
}
