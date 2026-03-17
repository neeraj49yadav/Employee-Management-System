import '../../../../core/network/api_client.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../models/dashboard_stats_model.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final ApiClient apiClient;

  DashboardRepositoryImpl(this.apiClient);

  @override
  Future<DashboardStats> fetchDashboardStats() async {
    final response = await apiClient.dio.get('/analytics/dashboard');
    return DashboardStatsModel.fromJson(response.data);
  }
}
