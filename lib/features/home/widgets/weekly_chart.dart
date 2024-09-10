import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeeklyChart extends StatelessWidget {
  const WeeklyChart({super.key});

  @override
  Widget build(BuildContext context) {
    /// Dummy Data Populated in Chart
    final List<ChartData> chartData = List.generate(
        7,
        (data) =>
            ChartData(++data, 400 + Random().nextDouble() * (2000 - 400)));
    return SfCartesianChart(
        title: const ChartTitle(
          text: 'Weekly Chart',
          textStyle: TextStyle(color: Colors.white, fontSize: 12),
        ),
        primaryXAxis: const NumericAxis(
          majorGridLines: MajorGridLines(width: 0),

          interval: 1,
          maximum: 7,
          title: AxisTitle(
            text: 'week',
            textStyle: TextStyle(color: Colors.white, fontSize: 8),
          ),
          // axisLine: AxisLine(color: Colors.white),
          labelStyle: TextStyle(color: Colors.white, fontSize: 8),
        ),
        primaryYAxis: const NumericAxis(
          minimum: 0,
          maximum: 2500, // Set maximum to 3000
          interval: 500,
          labelFormat: '',
          title: AxisTitle(
            text: 'PPM', // Keep label for y-axis
            textStyle: TextStyle(color: Colors.white, fontSize: 8),
          ),
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 8), // Show axis line and label
        ),
        series: <CartesianSeries>[
          // Renders spline chart
          SplineSeries<ChartData, int>(
            color: Colors.pink,
            trendlines: [
              Trendline(color: Colors.white, opacity: 0.5, width: 1)
            ],
            dataSource: chartData,
            // splineType: SplineType.cardinal,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,

            name: '24h Chart',
          )
        ]);
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double? y;
}
