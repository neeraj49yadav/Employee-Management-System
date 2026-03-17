import '../../domain/entities/dashboard_stats.dart';

class DashboardStatsModel extends DashboardStats {
  const DashboardStatsModel({
    required super.totalEmployees,
    required super.activeEmployees,
    required super.inactiveEmployees,
    required super.roleDistribution,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      totalEmployees: json['totalEmployees'],
      activeEmployees: json['activeEmployees'],
      inactiveEmployees: json['inactiveEmployees'],
      roleDistribution:
          Map<String, int>.from(json['roleDistribution']),
    );
  }
}
