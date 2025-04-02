import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/constant/content.dart';

class RightSidebar extends StatelessWidget {
  const RightSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            // Chart for Members
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    'Members Chart',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 180,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: 40,
                            color: Colors.blue,
                            title: '40%',
                            radius: 40,
                          ),
                          PieChartSectionData(
                            value: 30,
                            color: Colors.green,
                            title: '30%',
                            radius: 40,
                          ),
                          PieChartSectionData(
                            value: 20,
                            color: Colors.orange,
                            title: '20%',
                            radius: 40,
                          ),
                          PieChartSectionData(
                            value: 10,
                            color: Colors.red,
                            title: '10%',
                            radius: 40,
                          ),
                        ],
                        sectionsSpace: 3,
                        centerSpaceRadius: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Different Charts for Committees
            for (int i = 0; i < committees.length - 1; i++)
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      '${committees[i][1]} Chart',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 150,
                      child: BarChart(
                        BarChartData(
                          barGroups: [
                            BarChartGroupData(
                              x: 0,
                              barRods: [
                                BarChartRodData(
                                  toY: 10,
                                  color: Colors.blue,
                                  width: 15,
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 1,
                              barRods: [
                                BarChartRodData(
                                  toY: 15,
                                  color: Colors.green,
                                  width: 15,
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 2,
                              barRods: [
                                BarChartRodData(
                                  toY: 8,
                                  color: Colors.orange,
                                  width: 15,
                                ),
                              ],
                            ),
                          ],
                          titlesData: FlTitlesData(),
                          borderData: FlBorderData(show: false),
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
}
