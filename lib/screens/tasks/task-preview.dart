import 'package:data/bloc/tasks.bloc.dart';
import 'package:data/bloc_state/tasks.state.dart';
import 'package:data/constants.dart';
import 'package:data/entities/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TaskPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Task task = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;

    Task blTask = context.read<TasksBloc>().state.tasks.firstWhere((element) => element.id == task.id);

    return Scaffold(
      appBar: AppBar(
        title: Text("Task preview"),
        actions: <Widget>[
          BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) => IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Delete',
              onPressed: () {
                context.read<TasksBloc>().onDeleteTask(task);
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit',
            onPressed: () => Navigator.pushNamed(
              context,
              "/task/edit",
              arguments: blTask,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              var blocTask = context.read<TasksBloc>().state.tasks.firstWhere((element) => element.id == task.id);

             return Container(
                width: size.width,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: [
                              Text(
                                'Name',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                blocTask.name,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Grade',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                blocTask.grade.toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Timeline',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                '${new DateFormat('d MMM y').format(blocTask.due_date)} - ${new DateFormat('d MMM y').format(blocTask.completion_date)}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                blocTask.description,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              );
            }
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors_.primaryNormal,
        icon: const Icon(
          Icons.add,
          color: Colors_.grayscaleWhite,
        ),
        label: const Text('Add note',
            style: TextStyle(
              color: Colors_.grayscaleWhite,
            )),
      ),
    );
  }
}
