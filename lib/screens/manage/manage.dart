import 'package:flutter/material.dart';
import "package:data/constants.dart";
import "dart:math";

class ManageScreen extends StatefulWidget {
  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {


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
    return Container(
        padding: EdgeInsets.all(16),
      color: Colors.transparent,
      child: Column(
        children: [
         Expanded(child:
             GestureDetector(
               onTap: () => Navigator.pushNamed(context, "/data"),
               child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors_.infoPrimary,
                  ),

              child: Stack(children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Transform.rotate(
                      angle: -pi / 4,
                      child: Icon(Icons.insert_drive_file_outlined, size: 96)
                  )
                ),
                Center(child: Text("Data", style: TextStyle(color: Colors_.grayscaleWhite, fontSize: 28), )),

              ])
              ),
             )
         ),
          SizedBox(height: 12,),

          Expanded(child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, "/devices"),
            child: Container(

              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors_.successPrimary,

              ),
              child:  Stack(children: [
                  Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Transform.rotate(
                          angle: -pi / 4,
                          child: Icon(Icons.device_hub_outlined, size: 80)
                      )
                  ),
                  Center(child: Text("Devices", style: TextStyle(color: Colors_.grayscaleWhite, fontSize: 28), )),

                ])
              ),
            ),
          )
        ],
      )
    );
  }
}