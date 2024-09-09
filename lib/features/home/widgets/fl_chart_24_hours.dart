import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Chart24Hours extends StatelessWidget {
  const Chart24Hours({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> chartData = List.generate(
        24, (index) => FlSpot(index.toDouble(), Random().nextDouble()));

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          color: const Color.fromRGBO(75, 61, 133, 1), // Background color
          child: LineChart(
            LineChartData(
              titlesData: FlTitlesData(
                show: true,
                rightTitles: const AxisTitles(),
                topTitles: const AxisTitles(),
                bottomTitles: AxisTitles(
                  axisNameWidget: const Text(
                    '24h',
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  ),
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 4,
                    reservedSize: 22,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 8),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  axisNameWidget: const Text(
                    'ppm',
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  ),
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 8),
                      );
                    },
                  ),
                ),
              ),
              gridData: const FlGridData(show: false), // Disable grid lines
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: chartData,
                  isCurved: true,
                  dotData: const FlDotData(show: false),
                  color: Colors.white,
                  belowBarData: BarAreaData(
                    show: false,
                  ),
                ),
              ],
              minX: 0,
              maxX: 24,
              minY: 0,
              maxY: 1,
            ),
          ),
        ),
      ),
    );
  }
}
