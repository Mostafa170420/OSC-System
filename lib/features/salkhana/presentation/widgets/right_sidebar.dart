import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RightSidebar extends StatelessWidget {
  const RightSidebar({super.key});

  // Static data for member status
  final Map<String, int> memberStatusCounts = const {
    'accepted': 150,
    'rejected': 30,
    'waiting': 20,
  };

  // Static data for committees and their member counts (split into two groups)
  final Map<String, int> committeeGroup1Counts = const {
    'Flutter': 60,
    'Back-End': 80,
    'Front-End': 70,
  };

  final Map<String, int> committeeGroup2Counts = const {
    'UI-UX': 50,
    'Linux': 40,
    'Blender': 35,
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            // Chart for Members Status (Accepted, Rejected, Waiting)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    'Members Status',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 180,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: memberStatusCounts['accepted']!.toDouble(),
                            color: Colors.green,
                            title:
                                '${((memberStatusCounts['accepted']! / memberStatusCounts.values.reduce((a, b) => a + b)) * 100).toStringAsFixed(1)}%',
                            radius: 40,
                          ),
                          PieChartSectionData(
                            value: memberStatusCounts['rejected']!.toDouble(),
                            color: Colors.red,
                            title:
                                '${((memberStatusCounts['rejected']! / memberStatusCounts.values.reduce((a, b) => a + b)) * 100).toStringAsFixed(1)}%',
                            radius: 40,
                          ),
                          PieChartSectionData(
                            value: memberStatusCounts['waiting']!.toDouble(),
                            color: Colors.orange,
                            title:
                                '${((memberStatusCounts['waiting']! / memberStatusCounts.values.reduce((a, b) => a + b)) * 100).toStringAsFixed(1)}%',
                            radius: 40,
                          ),
                        ],
                        sectionsSpace: 3,
                        centerSpaceRadius: 30,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildIndicator(color: Colors.green, text: 'Accepted'),
                      const SizedBox(width: 8),
                      _buildIndicator(color: Colors.red, text: 'Rejected'),
                      const SizedBox(width: 8),
                      _buildIndicator(color: Colors.orange, text: 'Waiting'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // First Bar Chart for Committee Members Count (Group 1)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    'Committee Members (Part 1)',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150, // Adjust height as needed
                    child: BarChart(
                      BarChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                final index = value.toInt();
                                if (index >= 0 &&
                                    index < committeeGroup1Counts.length) {
                                  return Text(
                                    committeeGroup1Counts.keys.toList()[index],
                                    style: const TextStyle(fontSize: 12),
                                  );
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          leftTitles: const AxisTitles(
                            sideTitles:
                                SideTitles(showTitles: true, reservedSize: 30),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups:
                            _generateBarGroups(context, committeeGroup1Counts),
                      ),
                    ),
                  ),
                ],
              ),
            ),

// Second Bar Chart for Committee Members Count (Group 2)
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    'Committee Members (Part 2)',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150, // Adjust height as needed
                    child: BarChart(
                      BarChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                final index = value.toInt();
                                if (index >= 0 &&
                                    index < committeeGroup2Counts.length) {
                                  return Text(
                                    committeeGroup2Counts.keys.toList()[index],
                                    style: const TextStyle(fontSize: 12),
                                  );
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          leftTitles: const AxisTitles(
                            sideTitles:
                                SideTitles(showTitles: true, reservedSize: 30),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups:
                            _generateBarGroups(context, committeeGroup2Counts),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups(
      BuildContext context, Map<String, int> data) {
    final List<BarChartGroupData> barGroups = [];
    data.forEach((committee, count) {
      barGroups.add(
        BarChartGroupData(
          x: data.keys.toList().indexOf(committee),
          barRods: [
            BarChartRodData(
              toY: count.toDouble(),
              color: Theme.of(context).primaryColor,
              width: 16,
            ),
          ],
        ),
      );
    });
    return barGroups;
  }

  Widget _buildIndicator({required Color color, required String text}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }
}
