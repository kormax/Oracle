import 'package:flutter/material.dart';


class TodayScreen extends StatefulWidget {
  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {


  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            child: Text("Today screen")
          ),
          MaterialButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Container( child: Text("Hey"))),
            );
          },
          child: Text("button"),)
        ]
    );
  }
}