import 'package:flutter/material.dart';
import 'package:free_play_app/core/app_config.dart';
import 'package:free_play_app/core/router/router_manager.dart';
import 'package:signals_hooks/signals_hooks.dart';

import 'core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = appConfig.themeMode.value;
    return Watch.builder(
      builder: (context) {
        return MaterialApp.router(
          routerConfig: RouterManager().router,
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: _mapThemeMode(mode),
        );
      },
    );
  }

  ThemeMode _mapThemeMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}
