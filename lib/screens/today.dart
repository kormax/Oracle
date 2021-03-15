import 'package:data/widgets/bar_chart.dart';
import 'package:flutter/material.dart';
import "package:data/constants.dart";

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
    Size size = MediaQuery.of(context).size;
    double margin = size.width * 0.1;

    return SingleChildScrollView(
      child: SizedBox(
        height: size.height,
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.only(left: 16, top: 16, right: 16),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: EdgeInsets.all(16),
                  child:Column(children: [
                Row(children: [
                  Text(
                    "Status report",

                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Spacer()

                  ]),

                SizedBox(height: 8),

                Container(
                  height: 128 + 16.0,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors_.successSecondary,
                              borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          padding: EdgeInsets.all(16),
                          width: 128 * 3.0,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(
                              "Everything’s fine",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  height: 24/16,
                                  color: Colors_.successPrimary
                              ),
                            ),

                            SizedBox(height: 8,),
                            Expanded(child:
                              Text(
                                  "No incidents or events happened in past 7 days. Treat yourself.",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                    height: 24/16,
                                    color: Colors_.successPrimary
                                ),
                              )
                            )
                            ],
                          )
                        ),
                        SizedBox(width: 16,),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors_.warningSecondary,
                                borderRadius: BorderRadius.all(Radius.circular(8))
                            ),
                            padding: EdgeInsets.all(16),
                            width: 128 * 3.0,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Security tip",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      height: 24/16,
                                      color: Colors_.warningPrimary
                                  ),
                                ),

                                SizedBox(height: 8,),
                                Expanded(child:
                                Text(
                                  "You haven't changed your password in the past 87 days. It is advised to change it at least 5 times a day to be safe.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                      height: 24/16,
                                      color: Colors_.warningPrimary
                                  ),
                                )
                                )
                              ],
                            )
                        ),
                      ],
                  )
                )
              ])
              )
            ),


            Card(
              margin: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: BarChart(
                  title: "Scheduled tasks",
                  data: [0, 2, 1, 3, 4, 5, 6],
                  labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
                ),
              )
            )

          ],
        )
      )
    );
  }
}