import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart24Hours extends StatelessWidget {
  const Chart24Hours({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData =
        List.generate(24, (data) => ChartData(data, Random().nextDouble()));
    return Scaffold(
        body: Center(
            child: SfCartesianChart(
                title: const ChartTitle(
                  text: '24h Chart',
                  textStyle: TextStyle(color: Colors.white, fontSize: 12),
                ),
                primaryXAxis: const NumericAxis(
                  majorGridLines: MajorGridLines(width: 0),

                  interval: 4,
                  maximum: 25,
                  title: AxisTitle(
                    text: '24h',
                    textStyle: TextStyle(color: Colors.white, fontSize: 8),
                  ),
                  // axisLine: AxisLine(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white, fontSize: 8),
                ),
                primaryYAxis: const NumericAxis(
                  title: AxisTitle(
                    text: 'ppm',
                    textStyle: TextStyle(color: Colors.white, fontSize: 8),
                  ),
                  // axisLine: AxisLine(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white, fontSize: 8),
                ),
                backgroundColor: const Color.fromRGBO(75, 61, 133, 1),
                series: <CartesianSeries>[
          // Renders spline chart
          SplineSeries<ChartData, int>(
            dataSource: chartData,
            // splineType: SplineType.cardinal,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,

            name: '24h Chart',
          )
        ])));
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double? y;
}
