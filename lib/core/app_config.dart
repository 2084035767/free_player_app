import 'package:flutter/material.dart';
import 'package:signals_hooks/signals_hooks.dart';

enum AppThemeMode {
  system,
  light,
  dark,
}

/// 全局应用配置管理类
class AppConfig {
  AppConfig._();

  static final AppConfig _instance = AppConfig._();

  factory AppConfig() => _instance;

  final themeMode = signal<AppThemeMode>(AppThemeMode.system);
  final enableDebugLogging = signal<bool>(true);
  final apiTimeout = signal<int>(30000);
  final defaultPageSize = signal<int>(20);


  /// 设置主题模式
  void setThemeMode(AppThemeMode mode) {
    themeMode.value = mode;
  }

  /// 设置调试日志开关
  void setDebugLogging(bool enabled) {
    enableDebugLogging.value = enabled;
  }

  /// 设置API超时时间
  void setApiTimeout(int timeout) {
    apiTimeout.value = timeout;
  }

  /// 设置默认分页大小
  void setDefaultPageSize(int size) {
    defaultPageSize.value = size;
  }
}

/// 全局应用配置实例
final appConfig = AppConfig();