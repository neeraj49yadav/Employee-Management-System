import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';

class AuthApiService {
  final ApiClient apiClient;

  AuthApiService(this.apiClient);

  Future<Response> login(String email, String password) async {
    return await apiClient.dio.post(
      "/auth/login",
      data: {
        "email": email,
        "password": password,
      },
    );
  }

  Future<Response> register(
    String name,
    String email,
    String password,
  ) async {
    return await apiClient.dio.post(
      "/auth/register",
      data: {
        "name": name,
        "email": email,
        "password": password,
      },
    );
  }

  Future<Response> getProfile() async {
    return await apiClient.dio.get("/auth/profile");
  }
}