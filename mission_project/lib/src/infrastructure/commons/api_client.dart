import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<Either<String, T>> request<T>(
    String url, {
    String method = 'GET',
    dynamic body,
    Map<String, dynamic>? query,
    int retry = 0,
  }) async {
    int attempts = 0;

    while (true) {
      try {
        Response res;

        switch (method.toUpperCase()) {
          case 'POST':
            res = await _dio.post<T>(url, data: body, queryParameters: query);
            break;
          case 'PATCH':
            res = await _dio.patch<T>(url, data: body, queryParameters: query);
            break;
          case 'DELETE':
            res = await _dio.delete<T>(url, queryParameters: query);
            break;
          case 'GET':
          default:
            res = await _dio.get<T>(url, queryParameters: query);
        }

        if (res.statusCode != null &&
            res.statusCode! >= 200 &&
            res.statusCode! < 300) {
          return Right(res.data);
        }
        return Left("Status code: ${res.statusCode}");
      } catch (e) {
        if (attempts < retry) {
          attempts++;
          await Future.delayed(const Duration(seconds: 1));
          continue;
        }
        return Left("Exception: $e");
      }
    }
  }

  Future<Either<String, T>> get<T>(
    String url, {
    Map<String, dynamic>? query,
    int retry = 0,
  }) {
    return request(url, method: 'GET', query: query, retry: retry);
  }

  Future<Either<String, T>> post<T>(
    String url,
    dynamic body, {
    Map<String, dynamic>? query,
    int retry = 0,
  }) {
    return request(url, method: 'POST', body: body, query: query, retry: retry);
  }

  Future<Either<String, T>> patch<T>(
    String url,
    dynamic body, {
    Map<String, dynamic>? query,
    int retry = 0,
  }) {
    return request(
      url,
      method: 'PATCH',
      body: body,
      query: query,
      retry: retry,
    );
  }

  Future<Either<String, T>> delete<T>(
    String url, {
    Map<String, dynamic>? query,
    int retry = 0,
  }) {
    return request(url, method: 'DELETE', query: query, retry: retry);
  }
}
