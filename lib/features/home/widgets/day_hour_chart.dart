import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controller/home_controller.dart';

class Chart24Hours extends StatelessWidget {
  const Chart24Hours({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Obx(() {
      // Convert the RxList<int> to the chart data format for plotting
      final List<ChartData> data = List.generate(
        controller.chartData24h.length,
        (index) => ChartData(index, controller.chartData24h[index].toDouble()),
      );

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
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 8), // Axis line and label
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
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 8), // Axis line and label
        ),
        series: <CartesianSeries>[
          SplineSeries<ChartData, int>(
            dataSource: data,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            name: '24h CO2 Levels',
            color: Colors.blue,
          )
        ],
      );
    });
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x; // Hour (0-23)
  final double y; // PPM value
}
