import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DepartmentChart extends StatelessWidget {
  final Map<String, int> departments;

  const DepartmentChart({
    super.key,
    required this.departments,
  });

  @override
  Widget build(BuildContext context) {

    final sections = departments.entries.map((entry) {

      return PieChartSectionData(
        value: entry.value.toDouble(),
        title: entry.key,
        radius: 90,
      );

    }).toList();

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "Employees by Department",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: sections,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}