// lib/core/routing/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 页面路由配置
typedef RouteWidgetBuilder = Widget Function(BuildContext, GoRouterState);

class RouteConfig {
  final String path;
  final RouteWidgetBuilder builder;
  final List<GoRoute>? routes;
  final String name;
  final bool redirectToLogin;

  const RouteConfig({
    required this.path,
    required this.builder,
    this.routes,
    this.name = '',
    this.redirectToLogin = false,
  });

  /// 用于无参数页面的快捷构建
  factory RouteConfig.page({
    required String path,
    required Widget child,
    String name = '',
    bool redirectToLogin = false,
  }) {
    return RouteConfig(
      path: path,
      builder: (context, state) => child,
      name: name,
      redirectToLogin: redirectToLogin,
    );
  }
}

class RouteParams {
  static String getParam(GoRouterState state, String key) {
    return state.pathParameters[key] ?? '';
  }

  static Map<String, String> getQueryParams(GoRouterState state) {
    return state.uri.queryParameters;
  }

  static T? getExtra<T>(GoRouterState state) {
    return state.extra as T?;
  }
}
