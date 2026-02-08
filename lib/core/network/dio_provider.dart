// lib/core/network/dio_provider.dart
import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:free_play_app/core/error/api_exception.dart';
import 'package:injectable/injectable.dart';

@singleton
class DioProvider {
  DioProvider(this._dio);

  final Dio _dio;

  // ===== 通用请求方法 =====
  Future<dynamic> request({
    required String path,
    required String method,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(method: method),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } on SocketException {
      throw ApiException('No internet connection');
    } on TimeoutException {
      throw ApiException('Connection timeout');
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  // ===== HTTP 方法封装 =====
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) => request(
    path: path,
    method: 'GET',
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
    onReceiveProgress: onReceiveProgress,
  );

  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) => request(
    path: path,
    method: 'POST',
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
    onSendProgress: onSendProgress,
    onReceiveProgress: onReceiveProgress,
  );

  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) => request(
    path: path,
    method: 'PUT',
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
    onSendProgress: onSendProgress,
    onReceiveProgress: onReceiveProgress,
  );

  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) => request(
    path: path,
    method: 'DELETE',
    data: data,
    queryParameters: queryParameters,
    options: options,
    cancelToken: cancelToken,
  );

  // ===== 认证管理 =====
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  // ===== 错误处理 =====
  ApiException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException('Connection timeout');
      case DioExceptionType.receiveTimeout:
        return ApiException('Server response timeout');
      case DioExceptionType.badCertificate:
        return ApiException('Invalid SSL certificate');
      case DioExceptionType.cancel:
        return ApiException('Request cancelled');
      case DioExceptionType.connectionError:
        return ApiException('Network connection error');
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return ApiException('No internet connection');
        }
        return ApiException(error.message ?? 'Unknown network error');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.statusMessage ?? 'Request failed';

        // 业务错误处理
        if (statusCode == 401) {
          return ApiException('Unauthorized - please login again');
        }
        if (statusCode == 403) return ApiException('Forbidden access');
        if (statusCode == 404) return ApiException('Resource not found');
        if (statusCode == 500) return ApiException('Server internal error');

        return ApiException('HTTP $statusCode: $message');
      case DioExceptionType.sendTimeout:
        throw UnimplementedError();
    }
  }
}
