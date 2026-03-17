import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/dashboard_provider.dart';
import '../widgets/activity_log.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final stats = ref.watch(dashboardStatsProvider);

    return Padding(
      padding: const EdgeInsets.all(24),

      child: ListView(
        children: [

          const Text(
            "Dashboard",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [

              Expanded(
                child: _statCard(
                  title: "Total Employees",
                  value: stats.totalEmployees.toString(),
                  icon: Icons.people,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: _statCard(
                  title: "Departments",
                  value: stats.departmentCounts.length.toString(),
                  icon: Icons.business,
                ),
              ),

            ],
          ),

          const SizedBox(height: 30),

          const Text(
            "Departments",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          ...stats.departmentCounts.entries.map((entry) {

            return Card(
              child: ListTile(
                title: Text(entry.key),
                trailing: Text(entry.value.toString()),
              ),
            );

          }),

          const SizedBox(height: 30),

          ActivityLog(
            activities: stats.activities ?? [],
          ),

        ],
      ),
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
  }) {

    return Card(
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