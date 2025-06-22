import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BookChart extends StatelessWidget {
  final List<FlSpot> dataSpots;

  const BookChart({super.key, required this.dataSpots});

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
          border: Border(bottom: BorderSide(color: Colors.yellow, width: 4)),
        ),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            color: Colors.green,
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

  static SideTitles bottomTitles() => SideTitles(
    showTitles: true,
    interval: 1,
    getTitlesWidget: (value, meta) {
      return SideTitleWidget(meta: meta, child: Text('Day ${value.toInt()}'));
    },
  );

  static SideTitles leftTitles() => SideTitles(
    showTitles: true,
    interval: 1,
    getTitlesWidget: (value, meta) {
      return SideTitleWidget(meta: meta, child: Text('${value.toInt()}'));
    },
  );
}
