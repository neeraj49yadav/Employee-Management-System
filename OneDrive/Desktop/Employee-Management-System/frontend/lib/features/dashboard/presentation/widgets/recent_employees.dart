import 'package:flutter/material.dart';

class RecentEmployees extends StatelessWidget {

  final List<Map<String, dynamic>> employees;

  const RecentEmployees({
    super.key,
    required this.employees,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Recent Employees",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            DataTable(
              columns: const [

                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Department")),
                DataColumn(label: Text("Position")),

              ],

              rows: employees.map((e) {

                return DataRow(cells: [

                  DataCell(Text(e["name"])),
                  DataCell(Text(e["department"])),
                  DataCell(Text(e["position"])),

                ]);

              }).toList(),
            )

          ],
        ),
      ),
    );
  }
}