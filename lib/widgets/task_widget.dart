import 'package:data/constants.dart';
import 'package:data/entities/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TaskWidget extends StatelessWidget {
  final Task task;

  const TaskWidget({this.task});




  @override
  Widget build(BuildContext context) {
    void _onPressed() {
      Navigator.pushNamed(
        context,
        "/task/edit",
        arguments: task,
      );
    }

    return GestureDetector(
        onTap: _onPressed,

        child: Card(
            margin: EdgeInsets.only(left: 16, top: 16, right: 16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Column(children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(children: [
                    Text(this.task.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          height: 24/18
                        )
                    ),
                    Spacer(),
                    Text(this.task.dueDate.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0,
                            height: 24/14
                        )
                    ),

                    /*SizedBox(
                      height: 48,
                      width: 48,
                      child: IconButton(icon: Icon(Icons.edit), onPressed: _onPressed)
                    )*/

                  ]),
                ),

                Divider(height: 8,),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(children: [
                    Text(this.task.description),
                  ]),

                )
              ]),
            ));
  }
}
