import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/stat_model.dart';

class StatChart extends StatelessWidget {
  final List<StatDaily> data;
  final String title;
  final int Function(StatDaily) getValue;
  final Color color;

  const StatChart({
    super.key,
    required this.data,
    required this.title,
    required this.getValue,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          AspectRatio(
            aspectRatio: 4,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: true),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        int index = value.round();
                        if (index >= 0 && index < data.length) {
                          final date = data[index].date.substring(5, 10);
                          return SideTitleWidget(
                            space: 4,
                            meta: meta,
                            child: Text(
                              date,
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          meta: meta,
                          space: 4,
                          child: Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: true),
                minX: 0,
                maxX: (data.length - 1).toDouble(),
                minY: 0,
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: color,
                    barWidth: 2,
                    dotData: const FlDotData(show: true),
                    spots: List.generate(
                      data.length,
                      (index) => FlSpot(
                        index.toDouble(),
                        getValue(data[index]).toDouble(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
