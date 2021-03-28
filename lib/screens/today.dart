import 'dart:convert';

import 'package:data/entities/status.dart';
import 'package:data/services/status_service.dart';
import 'package:data/widgets/bar_chart.dart';
import 'package:data/widgets/containered_table_cell.dart';
import 'package:flutter/material.dart';
import "package:data/constants.dart";
import 'package:http/http.dart';

class TodayScreen extends StatefulWidget {
  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  StatusService _statusService = StatusService();

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

    return SingleChildScrollView(
        child: Column(children: [
      Card(
          margin: EdgeInsets.only(left: 16, top: 16, right: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(children: [
                Row(children: [
                  FutureBuilder<Status>(
                    future: _statusService.getStatus(),
                    builder: (context, snapshot) => Text(
                      snapshot.data?.header ?? "Loading",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
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
                                color: Colors_.infoSecondary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            padding: EdgeInsets.all(16),
                            width: 128 * 3.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder<Status>(
                                  future: _statusService.getStatus(),
                                  builder: (context, snapshot) => Text(
                                    snapshot.data?.status ?? "Loading",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        height: 24 / 16,
                                        color: Colors_.infoPrimary),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Expanded(
                                    child: FutureBuilder<Status>(
                                      future: _statusService.getStatus(),
                                      builder: (context, snapshot) => Text(
                                        snapshot.data?.message ?? "Loading",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16,
                                            height: 24 / 16,
                                            color: Colors_.infoPrimary),
                                      ),
                                    ),
                                )
                              ],
                            )),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors_.warningSecondary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
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
                                      height: 24 / 16,
                                      color: Colors_.warningPrimary),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Expanded(
                                    child: Text(
                                  "You haven't changed your password in the past 87 days. It is advised to change it at least 5 times a day to be safe.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                      height: 24 / 16,
                                      color: Colors_.warningPrimary),
                                ))
                              ],
                            )),
                      ],
                    ))
              ]))),
      Card(
          margin: EdgeInsets.only(left: 16, top: 16, right: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: FutureBuilder<Response>(
              future: _statusService.getWeeklyReport(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  Map<String, dynamic> data = jsonDecode(snapshot.data?.body);

                  return BarChart(
                    title: "Scheduled tasks",
                    data: [...data.values.map((e) => double.tryParse(e.toString()))],
                    labels: [...data.keys],
                  );
                } else {
                  return Text(
                    "Loading",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        height: 24 / 16,
                        color: Colors_.warningPrimary),
                  );
                }
              }
            )
          )),
      Card(
          margin: EdgeInsets.only(left: 16, top: 16, right: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(children: [
                Row(children: [
                  Text(
                    "Last readings",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer()
                ]),
                SizedBox(height: 8),
                Table(
                  border: TableBorder.symmetric(
                    inside:
                        BorderSide(width: 2, color: Colors_.grayscaleLightest),
                  ),
                  children: [
                    TableRow(children: [
                      ContaineredTableCell(child: Text('Time')),
                      ContaineredTableCell(child: Text('Sensor id')),
                      ContaineredTableCell(child: Text('Type')),
                      ContaineredTableCell(child: Text('Value')),
                    ]),

                    TableRow(children: [
                      ContaineredTableCell(child: Text('12:15')),
                      ContaineredTableCell(child: Text('ASD-S122')),
                      ContaineredTableCell(child: Text('Temperature')),
                      ContaineredTableCell(child: Text('15.00')),
                    ]),
                    TableRow(children: [
                      ContaineredTableCell(child: Text('12:13')),
                      ContaineredTableCell(child: Text('ASB-S121')),
                      ContaineredTableCell(child: Text('Temperature')),
                      ContaineredTableCell(child: Text('17.12')),
                    ]),
                    TableRow(children: [
                      ContaineredTableCell(child: Text('11:50')),
                      ContaineredTableCell(child: Text('ASB-S121')),
                      ContaineredTableCell(child: Text('Temperature')),
                      ContaineredTableCell(child: Text('17.10')),
                    ]),
                    TableRow(children: [
                      ContaineredTableCell(child: Text('11:03')),
                      ContaineredTableCell(child: Text('ASB-S121')),
                      ContaineredTableCell(child: Text('Temperature')),
                      ContaineredTableCell(child: Text('17.09')),
                    ]),
                    TableRow(children: [
                      ContaineredTableCell(child: Text('10:33')),
                      ContaineredTableCell(child: Text('ASB-S121')),
                      ContaineredTableCell(child: Text('Temperature')),
                      ContaineredTableCell(child: Text('17.09')),
                    ]),
                    //TableRow(),
                  ],
                ),
              ]))),
      Card(
          margin: EdgeInsets.only(left: 16, top: 16, right: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Padding(
              padding: EdgeInsets.all(32),
              child: Container(
                width: double.infinity,
                child: Column(children: [
                  Text(
                    "You're all caught up!",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Icon(
                    Icons.check_circle_outline_rounded,
                    color: Colors_.successPrimary,
                  )
                ]),
              ))),
      SizedBox(
        height: 16,
      )
    ]));
  }
}
