import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiClient {

  final Dio dio;

  ApiClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: "http://localhost:5000/api/v1",
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            headers: {
              "Content-Type": "application/json",
            },
          ),
        );

  /*
  |--------------------------------------------------------------------------
  | Set Auth Token
  |--------------------------------------------------------------------------
  */

  void setToken(String token) {
    dio.options.headers["Authorization"] = "Bearer $token";
  }

  /*
  |--------------------------------------------------------------------------
  | Clear Auth Token
  |--------------------------------------------------------------------------
  */

  void clearToken() {
    dio.options.headers.remove("Authorization");
  }
}

/*
|--------------------------------------------------------------------------
| Riverpod Provider
|--------------------------------------------------------------------------
*/

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});
