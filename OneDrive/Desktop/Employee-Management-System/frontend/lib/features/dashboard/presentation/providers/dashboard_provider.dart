import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardStats {

  final int totalEmployees;
  final Map<String, int> departmentCounts;
  final List<Map<String, dynamic>> recentEmployees;
  final List<String> activities;

  DashboardStats({
    required this.totalEmployees,
    required this.departmentCounts,
    required this.recentEmployees,
    required this.activities,
  });

}

final dashboardStatsProvider = Provider<DashboardStats>((ref) {

  return DashboardStats(

    totalEmployees: 7,

    departmentCounts: {
      "Engineering": 3,
      "HR": 3,
      "HR (lower)": 1,
    },

    recentEmployees: [
      {
        "name": "John",
        "department": "Engineering",
        "position": "Developer"
      },
      {
        "name": "Jane",
        "department": "HR",
        "position": "Manager"
      },
      {
        "name": "Alex",
        "department": "Engineering",
        "position": "DevOps"
      },
    ],

    activities: [
      "CREATED: John Doe (Engineering)",
      "UPDATED: Jane Smith (HR)",
      "DELETED: Alex Brown (Engineering)",
    ],

  );

});