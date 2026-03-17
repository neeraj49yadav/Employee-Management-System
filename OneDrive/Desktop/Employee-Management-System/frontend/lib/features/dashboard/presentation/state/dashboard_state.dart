import '../../domain/entities/dashboard_stats.dart';

class DashboardState {
  final DashboardStats? stats;
  final bool isLoading;
  final String? error;

  const DashboardState({
    this.stats,
    this.isLoading = false,
    this.error,
  });

  DashboardState copyWith({
    DashboardStats? stats,
    bool? isLoading,
    String? error,
  }) {
    return DashboardState(
      stats: stats ?? this.stats,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
