import 'package:fl_chart/fl_chart.dart' as FlChart;
import 'package:flutter/material.dart';


class BarChart extends StatelessWidget {
  final List<double> data;
  final String title;
  final List<String> labels;

  const BarChart({@required this.title, @required this.data, @required this.labels});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all( Radius.circular(16.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: MediaQuery.of(context).size.width,
            child: FlChart.BarChart(
              FlChart.BarChartData(
                alignment: FlChart.BarChartAlignment.spaceAround,
                maxY: 16.0,
                barTouchData: FlChart.BarTouchData(enabled: false),
                titlesData: FlChart.FlTitlesData(
                  show: true,
                  bottomTitles: FlChart.SideTitles(
                    margin: 10.0,
                    showTitles: true,
                    rotateAngle: 35.0,
                    getTitles: (double value) => this.labels[value.toInt()],
                  ),
                  leftTitles: FlChart.SideTitles(
                      margin: 10.0,
                      showTitles: true,
                      getTitles: (value) {
                        if (value == 0) {
                          return '0';
                        } else if (value % 3 == 0) {
                          return '${value ~/ 3 * 5}';
                        }
                        return '';
                      }),
                ),
                gridData: FlChart.FlGridData(
                  show: true,
                  checkToShowHorizontalLine: (value) => value % 3 == 0,
                  getDrawingHorizontalLine: (value) => FlChart.FlLine(
                    color: Colors.black12,
                    strokeWidth: 1.0,
                    dashArray: [5],
                  ),
                ),
                borderData: FlChart.FlBorderData(show: false),
                barGroups: data
                    .asMap()
                    .map((key, value) => MapEntry(
                    key,
                    FlChart.BarChartGroupData(
                      x: key,
                      barRods: [
                        FlChart.BarChartRodData(
                          y: value,
                          colors: [Colors.red],
                        ),
                      ],
                    )))
                    .values
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}