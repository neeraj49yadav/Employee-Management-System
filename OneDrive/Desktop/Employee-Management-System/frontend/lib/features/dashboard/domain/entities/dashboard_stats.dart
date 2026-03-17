import 'package:equatable/equatable.dart';

class DashboardStats extends Equatable {
  final int totalEmployees;
  final int activeEmployees;
  final int inactiveEmployees;
  final Map<String, int> roleDistribution;

  const DashboardStats({
    required this.totalEmployees,
    required this.activeEmployees,
    required this.inactiveEmployees,
    required this.roleDistribution,
  });

  @override
  List<Object?> get props => [
        totalEmployees,
        activeEmployees,
        inactiveEmployees,
        roleDistribution,
      ];
}
