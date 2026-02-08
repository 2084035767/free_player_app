// lib/di/network_module.dart
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:free_play_app/core/app_config.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart'; // 推荐的日志拦截器

@module
abstract class NetworkModule {
  @singleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        responseType: ResponseType.json,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': AppConfig.userAgent,
        },
      ),
    );

    _setupInterceptors(dio);
    return dio;
  }

  /// 配置 Dio 拦截器
  void _setupInterceptors(Dio dio) {
    // 重试拦截器
    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        retries: 3,
        retryDelays: const [
          Duration(milliseconds: 500),
          Duration(seconds: 1),
          Duration(seconds: 2),
        ],
        retryEvaluator: (err, _) => err.type != DioExceptionType.cancel,
      ),
    );
    // 日志拦截器
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    // 业务拦截器
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 移除 gzip 头（某些服务器不支持）
          options.headers.remove('accept-encoding');

          // 可在此添加通用参数（如设备ID）
          // options.queryParameters['device_id'] = AppConfig.deviceId;

          return handler.next(options);
        },
        onResponse: (response, handler) {
          // 可在此添加统一业务状态码处理
          if (response.statusCode == 200) {
            response.data = json.decode(response.data);
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          // 统一错误预处理（如401跳转登录）
          if (error.response?.statusCode == 401) {
            // 可触发全局登出事件
            // EventBus().fire(AuthExpiredEvent());
          }
          return handler.next(error);
        },
      ),
    );
  }
}
