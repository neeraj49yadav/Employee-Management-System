// lib/features/auth/data/repositories/auth_repository_impl.dart

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/secure_storage_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient;
  final SecureStorageService storage;

  AuthRepositoryImpl(this.apiClient, this.storage);

  @override
  Future<User> login(String email, String password) async {
    final response = await apiClient.dio.post(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    final data = response.data['data'];

    return User(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      role: data['role'] ?? 'USER',
      permissions:
          (data['permissions'] as List<dynamic>? ?? [])
              .map((e) => e.toString())
              .toList(),
    );
  }

  @override
  Future<User> getCurrentUser() async {
    final response = await apiClient.dio.get('/auth/me');

    final data = response.data['data'];

    return User(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      role: data['role'] ?? 'USER',
      permissions:
          (data['permissions'] as List<dynamic>? ?? [])
              .map((e) => e.toString())
              .toList(),
    );
  }

  @override
  Future<void> logout() async {
    try {
      await apiClient.dio.post('/auth/logout');
    } catch (_) {}

    await storage.clear();
  }
}