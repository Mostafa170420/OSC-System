import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/functions.dart';
import '../../data/model/member.dart';

class RightSidebar extends StatelessWidget {
  final List<SalkhanaMemberModel> members;
  final List<List<String>> committees;

  const RightSidebar(
      {super.key, required this.members, required this.committees});

  @override
  Widget build(BuildContext context) {
    final overallStats = calculateOverallStats(members);
    final committeeStats = calculateCommitteeStats(members, committees);

    final totalMembers =
        overallStats.accepted + overallStats.rejected + overallStats.pending;

    final committeeNames = committeeStats.keys.toList();
    final committeeGroup1 = <String, ChartStats>{};
    final committeeGroup2 = <String, ChartStats>{};

    final midIndex = (committeeNames.length / 2).ceil();
    for (var i = 0; i < committeeNames.length; i++) {
      if (i < midIndex) {
        committeeGroup1[committeeNames[i]] = committeeStats[committeeNames[i]]!;
      } else {
        committeeGroup2[committeeNames[i]] = committeeStats[committeeNames[i]]!;
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: [
            // Chart for Members Status (Accepted, Rejected, Pending)
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
                    height: 150,
                    child: PieChart(
                      key: ValueKey(overallStats.hashCode),
                      PieChartData(
                        borderData: FlBorderData(show: false),
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            if (event is! FlLongPressEnd &&
                                event is! PointerUpEvent) {
                              return;
                            }
                          },
                        ),
                        sections: [
                          PieChartSectionData(
                            value: overallStats.accepted.toDouble(),
                            color: Colors.green,
                            title: totalMembers == 0
                                ? '0%'
                                : '${((overallStats.accepted / totalMembers) * 100).toStringAsFixed(1)}%',
                            radius: 40,
                          ),
                          PieChartSectionData(
                            value: overallStats.rejected.toDouble(),
                            color: Colors.red,
                            title: totalMembers == 0
                                ? '0%'
                                : '${((overallStats.rejected / totalMembers) * 100).toStringAsFixed(1)}%',
                            radius: 40,
                          ),
                          PieChartSectionData(
                            value: overallStats.pending.toDouble(),
                            color: Colors.blue,
                            title: totalMembers == 0
                                ? '0%'
                                : '${((overallStats.pending / totalMembers) * 100).toStringAsFixed(1)}%',
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
                      Flexible(
                          child: _buildIndicator(
                              color: Colors.green, text: 'Accepted')),
                      const SizedBox(width: 8),
                      Flexible(
                          child: _buildIndicator(
                              color: Colors.red, text: 'Rejected')),
                      const SizedBox(width: 8),
                      Flexible(
                          child: _buildIndicator(
                              color: Colors.blue, text: 'Waiting')),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // First Bar Chart for Committee Members Count (Group 1)
            if (committeeGroup1.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      'Committee Status (Part 1)',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 150, // Adjust height as needed
                      child: BarChart(
                        key: ValueKey(committeeGroup1.hashCode),
                        BarChartData(
                          gridData: const FlGridData(show: false),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              axisNameSize: 10,
                              sideTitles: SideTitles(
                                reservedSize: 30,
                                showTitles: true,
                                getTitlesWidget:
                                    (double value, TitleMeta meta) {
                                  final index = value.toInt();
                                  if (index >= 0 &&
                                      index < committeeGroup1.length) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Text(
                                        committeeGroup1.keys.toList()[index],
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }
                                  return const Text('');
                                },
                              ),
                            ),
                            leftTitles: const AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: true, reservedSize: 30),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: _generateBarGroupsForCommitteeStatus(
                              context, committeeGroup1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (committeeGroup1.isNotEmpty) const SizedBox(height: 10),
            // Second Bar Chart for Committee Members Count (Group 2)
            if (committeeGroup2.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      'Committee Status (Part 2)',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 150, // Adjust height as needed
                      child: BarChart(
                        key:
                            ValueKey(committeeGroup2.hashCode), // Important key
                        BarChartData(
                          gridData: const FlGridData(show: false),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget:
                                    (double value, TitleMeta meta) {
                                  final index = value.toInt();
                                  if (index >= 0 &&
                                      index < committeeGroup2.length) {
                                    return Text(
                                      committeeGroup2.keys.toList()[index],
                                      style: const TextStyle(fontSize: 12),
                                    );
                                  }
                                  return const Text('');
                                },
                              ),
                            ),
                            leftTitles: const AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: true, reservedSize: 30),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: _generateBarGroupsForCommitteeStatus(
                              context, committeeGroup2),
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

  List<BarChartGroupData> _generateBarGroupsForCommitteeStatus(
      BuildContext context, Map<String, ChartStats> data) {
    final List<BarChartGroupData> barGroups = [];
    data.forEach((committee, stats) {
      barGroups.add(
        BarChartGroupData(
          x: data.keys.toList().indexOf(committee),
          barRods: [
            BarChartRodData(
              toY: stats.accepted.toDouble(),
              color: Colors.green.withOpacity(0.7),
              width: 10,
            ),
            BarChartRodData(
              toY: stats.rejected.toDouble(),
              color: Colors.red.withOpacity(0.7),
              width: 10,
            ),
            BarChartRodData(
              toY: stats.pending.toDouble(),
              color: Colors.blue.withOpacity(0.7),
              width: 10,
            ),
          ],
        ),
      );
    });
    return barGroups;
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
              width: 12,
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
        Flexible(
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(child: Text(text)),
      ],
    );
  }
}
