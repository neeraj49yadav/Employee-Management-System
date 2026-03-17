import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? token;
  final String? error;

  AuthState({
    required this.isAuthenticated,
    required this.isLoading,
    this.token,
    this.error,
  });

  factory AuthState.initial() {
    return AuthState(
      isAuthenticated: false,
      isLoading: false,
      token: null,
      error: null,
    );
  }

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    String? token,
    String? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      token: token ?? this.token,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;

  AuthNotifier(this.ref) : super(AuthState.initial());

  Future<void> login(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final apiClient = ref.read(apiClientProvider);

      final response = await apiClient.dio.post(
        "/auth/login",
        data: {
          "email": email,
          "password": password,
        },
      );

      final token = response.data["token"];

      apiClient.setToken(token);

      state = state.copyWith(
        isAuthenticated: true,
        isLoading: false,
        token: token,
      );
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.response?.data["message"] ?? "Login failed",
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Login failed",
      );
    }
  }

  void logout() {
    final apiClient = ref.read(apiClientProvider);

    apiClient.clearToken();

    state = AuthState.initial();
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});