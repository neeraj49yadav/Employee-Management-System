import 'package:dio/dio.dart';

import '../storage/secure_storage_service.dart';
import '../services/snackbar_service.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final SecureStorageService storage;

  Future<String?>? _refreshFuture;

  AuthInterceptor(this.dio, this.storage);

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler) async {
    final token = await storage.getAccessToken();

    if (token != null) {
      options.headers['Authorization'] =
          'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    // Handle 401 with refresh
    if (statusCode == 401) {
      try {
        _refreshFuture ??= _refreshToken();
        final newToken = await _refreshFuture;
        _refreshFuture = null;

        if (newToken == null) {
          await storage.clear();
          SnackbarService.showError(
              "Session expired. Please login again.");
          return handler.next(err);
        }

        final requestOptions = err.requestOptions;
        requestOptions.headers['Authorization'] =
            'Bearer $newToken';

        final response =
            await dio.fetch(requestOptions);
        return handler.resolve(response);
      } catch (_) {
        await storage.clear();
        SnackbarService.showError(
            "Authentication failed.");
        return handler.next(err);
      }
    }

    // Handle other errors globally
    final message =
        err.response?.data?['message'] ??
            "Something went wrong";

    SnackbarService.showError(message);

    handler.next(err);
  }

  Future<String?> _refreshToken() async {
    try {
      final response =
          await dio.post('/auth/refresh');

      final newToken =
          response.data['accessToken'];

      await storage.saveAccessToken(newToken);

      return newToken;
    } catch (_) {
      return null;
    }
  }
}
