import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:line_icons/line_icons.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// 应用主题模式
enum AppThemeMode {
  light(Icons.sunny, '浅色模式'),
  dark(Icons.nights_stay, '深色模式');

  const AppThemeMode(this.icon, this.label);
  final IconData icon;
  final String label;
  IconData get iconData =>
      this == AppThemeMode.dark ? LineIcons.sun : LineIcons.moon;
  AppThemeMode get toggled =>
      this == AppThemeMode.dark ? AppThemeMode.light : AppThemeMode.dark;
}

@singleton
class AppConfig {
  AppConfig() {
    _restoreFromStorage();
  }
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://jinyingzy.com/provide/vod',
  );
  static const String userAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
      'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36';
  // ===== 响应式信号（Signals）=====
  final themeMode = signal(AppThemeMode.light);
  final enableDebugLogging = signal(true);
  final apiTimeout = signal(Duration(seconds: 30));
  final defaultPageSize = signal(20);

  // ===== 配置操作 =====
  /// 切换主题模式
  void toggleTheme() => themeMode.value = themeMode.value.toggled;

  /// 设置主题模式
  void setThemeMode(AppThemeMode mode) => themeMode.value = mode;

  /// 设置调试日志开关
  void setDebugLogging(bool enabled) => enableDebugLogging.value = enabled;

  /// 设置API超时
  void setApiTimeout(Duration timeout) => apiTimeout.value = timeout;

  /// 设置默认分页大小
  void setDefaultPageSize(int size) => defaultPageSize.value = size;

  // ===== 持久化支持（可选）=====
  Future<void> _restoreFromStorage() async {
    // 示例：从 SharedPreferences 恢复配置
    // final prefs = await SharedPreferences.getInstance();
    // final savedTheme = prefs.getString('theme_mode');
    // if (savedTheme != null) {
    //   themeMode.value = AppThemeMode.values.firstWhere(
    //     (e) => e.name == savedTheme,
    //     orElse: () => RuntimeConfig.defaultConfig.themeMode,
    //   );
    // }
  }

  Future<void> persistToStorage() async {
    // 示例：保存配置到 SharedPreferences
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('theme_mode', themeMode.value.name);
  }
}
