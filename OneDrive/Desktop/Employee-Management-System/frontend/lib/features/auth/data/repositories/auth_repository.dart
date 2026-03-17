import '../services/auth_api_service.dart';

class AuthRepository {
  final AuthApiService apiService;

  AuthRepository(this.apiService);

  Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await apiService.login(email, password);
    return response.data;
  }

  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    final response = await apiService.register(name, email, password);
    return response.data;
  }

  Future<Map<String, dynamic>> profile() async {
    final response = await apiService.getProfile();
    return response.data;
  }
}