import 'package:books/screens/stats/book_stat.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryChart extends StatelessWidget {
  final List<FlSpot> dataSpots;

  const CategoryChart({super.key, required this.dataSpots});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(sideTitles: bottomTitles()),
          leftTitles: AxisTitles(sideTitles: leftTitles()),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: Color.fromARGB(255, 138, 64, 236).withOpacity(0.2),
              width: 4,
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            color: Color.fromARGB(255, 138, 64, 236),
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
            spots: dataSpots,
          ),
        ],
      ),
    );
  }

  static SideTitles bottomTitles() => BookChart.bottomTitles();
  static SideTitles leftTitles() => BookChart.leftTitles();
}
