import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client.dart';
import '../../data/services/auth_api_service.dart';
import '../../data/repositories/auth_repository.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

final authApiServiceProvider = Provider<AuthApiService>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return AuthApiService(apiClient);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final service = ref.read(authApiServiceProvider);
  return AuthRepository(service);
});