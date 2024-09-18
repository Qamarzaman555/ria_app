import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeeklyChart extends StatelessWidget {
  final List<double> yValues; // Receive y-values (CO2 levels) for the week

  const WeeklyChart({super.key, required this.yValues});

  @override
  Widget build(BuildContext context) {
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
          text: 'Week',
          textStyle: TextStyle(color: Colors.white, fontSize: 8),
        ),
        labelStyle: TextStyle(color: Colors.white, fontSize: 8),
      ),
      primaryYAxis: const NumericAxis(
        minimum: 0,
        maximum: 3000, // Set maximum to 3000 PPM
        interval: 500,
        labelFormat: '',
        title: AxisTitle(
          text: 'PPM',
          textStyle: TextStyle(color: Colors.white, fontSize: 8),
        ),
        labelStyle: TextStyle(color: Colors.white, fontSize: 8),
      ),
      series: <CartesianSeries>[
        SplineSeries<ChartData, int>(
          color: Colors.pink,
          trendlines: [Trendline(color: Colors.white, opacity: 0.5, width: 1)],
          dataSource: _generateChartData(yValues), // Use reusable method
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          name: 'Weekly CO2 Levels',
        )
      ],
    );
  }

  /// Reusable method to generate chart data from provided yValues (CO2 levels)
  List<ChartData> _generateChartData(List<double> yValues) {
    // Assuming the data points are for each day of the week (0-6)
    return List.generate(
      yValues.length,
      (index) => ChartData(index, yValues[index]),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x; // Day of the week (0-6)
  final double y;
}
