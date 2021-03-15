import 'package:data/constants.dart';
import 'package:data/entities/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TaskWidget extends StatelessWidget {
  final Task task;

  const TaskWidget({this.task});

  @override
  Widget build(BuildContext context) {
    // return ListTile(
    //     title: Padding(
    //         padding: EdgeInsets.all(20),
    //         child: Container(
    //           child: Text(this.task.name),
    //         )));
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            "/task-edit",
            arguments: task,
          );
        },
        child: Card(
            margin: EdgeInsets.only(left: 16, top: 16, right: 16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(children: [
                Row(children: [
                  Text(this.task.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      )),
                ]),
                SizedBox(height: 5),
                Container(
                  child: Text(this.task.description),
                  decoration: BoxDecoration(
                      color: Colors_.primaryLightest,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  padding: EdgeInsets.all(16),
                  width: 128 * 3.0,
                )
              ]),
            )));
  }
}
