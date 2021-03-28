import 'package:data/bloc/tasks.bloc.dart';
import 'package:data/bloc_state/tasks.state.dart';
import 'package:data/constants.dart';
import 'package:data/entities/task.dart';
import 'package:data/utils/form_group_util.dart';
import 'package:data/widgets/button.dart';
import 'package:data/widgets/date_picker.dart';
import 'package:data/widgets/entry_field.dart';
import 'package:data/widgets/entry_field_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskEditorScreen extends StatefulWidget {
  @override
  _TaskEditorScreenState createState() => _TaskEditorScreenState();
}

class _TaskEditorScreenState extends State<TaskEditorScreen> {
  FormGroupUtil taskFormGroup =
  new FormGroupUtil(
      [
        'creator_id',
        'assignee_id',
        'name',
        'description',
        'priority',
        'status',
        'due_date',
        'completion_date',
        'grade'
      ]);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double margin = size.width * 0.1;

    final Task taskToEdit = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text(taskToEdit == null ? "Task creation" : "Task editing"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16),
              EntryField(
                label: "Creator id",
                type: EntryFieldType.plaintext,
                value: taskToEdit?.name?.toString(),
                controller: taskFormGroup.getFormControl('creator_id'),
              ),
              EntryField(
                label: "Assignee id",
                type: EntryFieldType.plaintext,
                value: taskToEdit?.description?.toString(),
                controller: taskFormGroup.getFormControl('assignee_id'),
              ),
              Divider(height: 32),
              EntryField(
                label: "Name",
                type: EntryFieldType.plaintext,
                value: taskToEdit?.name?.toString(),
                controller: taskFormGroup.getFormControl('name'),
              ),
              EntryField(
                label: "Description",
                type: EntryFieldType.plaintext,
                value: taskToEdit?.description?.toString(),
                controller: taskFormGroup.getFormControl('description'),
              ),
              Divider(height: 32),
              EntryField(
                label: "Priority",
                type: EntryFieldType.integer,
                value: taskToEdit?.priority?.toString(),
                controller: taskFormGroup.getFormControl('priority'),
              ),
              EntryField(
                label: "Status",
                type: EntryFieldType.plaintext,
                value: taskToEdit?.status?.toString(),
                controller: taskFormGroup.getFormControl('status'),
              ),
              Divider(height: 32),
              DatePicker("Due date", controller: taskFormGroup.getFormControl('due_date'),),
              SizedBox(height: 16),
              DatePicker("Completion date", controller: taskFormGroup.getFormControl('completion_date')),
              Divider(height: 32),
              SizedBox(height: 16),
              EntryField(
                label: "Grade",
                type: EntryFieldType.integer,
                value: taskToEdit?.grade?.toString(),
                controller: taskFormGroup.getFormControl('grade'),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: BlocBuilder<TasksBloc, TasksState>(
                    builder: (context, state) => Button(
                      text: "Save",
                      color: Colors_.primaryNormal,
                      textColor: Colors_.grayscaleWhite,
                      onPressed: () {
                        if (taskToEdit?.id == null) {
                          print(taskFormGroup.getFormGroupValue()['due_date']);

                          context.read<TasksBloc>().onAddTask(
                              Task.taskAddFromJson(taskFormGroup.getFormGroupValue()));
                        } else {
                          context.read<TasksBloc>().onUpdateTask(
                              Task.fromJson(taskFormGroup.getFormGroupValue()));
                        }

                        // Navigator.pop(context);
                      },
                    ),
                  )
              ),
              SizedBox(height: margin),
            ],
          ),
        ));
  }
}
