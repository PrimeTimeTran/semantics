import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

// https://www.atatus.com/blog/design-stunning-charts-with-fl-charts-in-flutter/#making-a-line-chart

class Charts extends StatefulWidget {
  const Charts({super.key, required this.title});
  final String title;

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  @override
  void initState() {
    super.initState();
  }

  // Generate some dummy data for the c
  // This will be used to draw the indigo line
  final List<FlSpot> dummyData1 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the orange line
  final List<FlSpot> dummyData2 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the blue line
  final List<FlSpot> dummyData3 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  }); // Generate some dummy data for the chart

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(show: false),
          lineBarsData: [
            // The indigo line
            LineChartBarData(
              spots: dummyData1,
              isCurved: true,
              barWidth: 3,
              color: Colors.indigo,
            ),
            // The red line
            LineChartBarData(
              spots: dummyData2,
              isCurved: true,
              barWidth: 3,
              color: Colors.red,
            ),
            // The blue line
            LineChartBarData(
              spots: dummyData3,
              isCurved: false,
              barWidth: 3,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
