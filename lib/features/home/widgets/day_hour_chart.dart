import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart24Hours extends StatelessWidget {
  const Chart24Hours({super.key});

  @override
  Widget build(BuildContext context) {
    /// Generate PPM values between 400 and 3000 for 24 hours
    final List<ChartData> chartData = List.generate(
      24,
      (data) => ChartData(data, 400 + Random().nextDouble() * (2000 - 400)),
    );

    return SfCartesianChart(
      title: const ChartTitle(
        text: '24h Chart',
        textStyle: TextStyle(color: Colors.white, fontSize: 12),
      ),
      primaryXAxis: const NumericAxis(
        majorGridLines: MajorGridLines(width: 0),
        interval: 2, // Interval for every 4 hours
        maximum: 24, // 24 hours
        labelFormat: '', // Hide the numeric values
        title: AxisTitle(
          text: '24h', // Keep label for x-axis
          textStyle: TextStyle(color: Colors.white, fontSize: 8),
        ),
        labelStyle: TextStyle(
            color: Colors.white, fontSize: 8), // Still show axis line and label
      ),
      primaryYAxis: const NumericAxis(
        minimum: 0,
        maximum: 3000, // Set maximum to 3000
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
        SplineSeries<ChartData, int>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          name: '24h Chart',
        )
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x; // Hour (0-23)
  final double? y; // PPM value (400 - 3000)
}
