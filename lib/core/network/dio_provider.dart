import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

import '../error/api_exception.dart';

class DioProvider {
  static final DioProvider _instance = DioProvider._internal();
  late final Dio _dio;

  factory DioProvider() => _instance;
  DioProvider._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://jinyingzy.com/provide/vod',
        responseType: ResponseType.plain,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        },
      ),
    );

    _setupInterceptors();
  }

  Dio get dio => _dio;

  void _setupInterceptors() {
    // 日志拦截器
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );
    _dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        retries: 3, // 总共重试 3 次
        retryDelays: const [
          // 每次重试前等待
          Duration(milliseconds: 500),
          Duration(milliseconds: 1000),
          Duration(seconds: 1),
        ],
        retryEvaluator: (err, attempt) =>
            err.type != DioExceptionType.cancel, // 非取消错误都重试
      ),
    );

    // 请求和响应拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers.remove('accept-encoding');
          // 在这里可以添加认证令牌等
          // 例如: options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (response.statusCode == 200) {
            response.data = json.decode(response.data);
          } else {
            throw ApiException(
              'Unexpected status code: ${response.statusCode}',
            );
          }
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  // 通用请求方法
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
      throw ApiException(e.message ?? 'Network error occurred');
    } on SocketException {
      throw ApiException('No internet connection');
    } on TimeoutException {
      throw ApiException('Connection timeout');
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  // GET 请求
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return request(
      path: path,
      method: 'GET',
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // POST 请求
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return request(
      path: path,
      method: 'POST',
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // PUT 请求
  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return request(
      path: path,
      method: 'PUT',
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // DELETE 请求
  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return request(
      path: path,
      method: 'DELETE',
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  // 设置认证令牌
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // 清除认证令牌
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }
}
