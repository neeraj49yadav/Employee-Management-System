import 'package:flutter/material.dart';

class StatsCards extends StatelessWidget {

  final int totalEmployees;
  final int departments;

  const StatsCards({
    super.key,
    required this.totalEmployees,
    required this.departments,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [

        Expanded(
          child: _card(
            icon: Icons.people,
            title: "Employees",
            value: totalEmployees.toString(),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _card(
            icon: Icons.business,
            title: "Departments",
            value: departments.toString(),
          ),
        ),

      ],
    );
  }

  Widget _card({
    required IconData icon,
    required String title,
    required String value,
  }) {

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Row(
          children: [

            Icon(icon, size: 32),

            const SizedBox(width: 16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(title),

                const SizedBox(height: 5),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            )

          ],
        ),
      ),
    );
  }
}