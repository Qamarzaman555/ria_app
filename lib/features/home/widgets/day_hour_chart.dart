import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart24Hours extends StatelessWidget {
  final List<double> yValues; // Receive y values (CO2 levels)

  const Chart24Hours({super.key, required this.yValues});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: const ChartTitle(
        text: '24h CO2 Levels',
        textStyle: TextStyle(color: Colors.white, fontSize: 12),
      ),
      primaryXAxis: const NumericAxis(
        majorGridLines: MajorGridLines(width: 0),
        interval: 2, // Interval for every 4 hours
        maximum: 24, // 24 hours
        labelFormat: '', // Hide the numeric values
        title: AxisTitle(
          text: '24h', // Label for x-axis
          textStyle: TextStyle(color: Colors.white, fontSize: 8),
        ),
        labelStyle:
            TextStyle(color: Colors.white, fontSize: 8), // Axis line and label
      ),
      primaryYAxis: const NumericAxis(
        minimum: 0,
        maximum: 3000, // Set maximum to 3000 PPM
        interval: 500,
        labelFormat: '',
        title: AxisTitle(
          text: 'PPM', // Label for y-axis
          textStyle: TextStyle(color: Colors.white, fontSize: 8),
        ),
        labelStyle:
            TextStyle(color: Colors.white, fontSize: 8), // Axis line and label
      ),
      series: <CartesianSeries>[
        SplineSeries<ChartData, int>(
          dataSource: _generateChartData(yValues), // Use the reusable method
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          name: '24h CO2 Levels',
          color: Colors.blue,
        )
      ],
    );
  }

  /// Reusable method to generate chart data from provided yValues (CO2 levels)
  List<ChartData> _generateChartData(List<double> yValues) {
    return List.generate(
      yValues.length,
      (index) => ChartData(index, yValues[index]),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x; // Hour (0-23)
  final double y;
}
