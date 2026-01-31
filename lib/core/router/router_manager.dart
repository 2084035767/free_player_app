// lib/core/routing/router_manager.dart
import 'package:flutter/material.dart';
import 'package:free_play_app/screens/auth/login_screen.dart';
import 'package:free_play_app/screens/category/category_screen.dart';
import 'package:free_play_app/screens/explore/explore_screen.dart';
import 'package:free_play_app/screens/home/home_screen.dart';
import 'package:free_play_app/screens/home/search_screen.dart';
import 'package:free_play_app/screens/mine/profile_screen.dart';
import 'package:free_play_app/screens/play/player_screen.dart';
import 'package:free_play_app/viewmodels/auth_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'app_router.dart';

/// 路由路径常量
class RoutePaths {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String search = '/search';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String player = '/player/:id';
  static const String explore = '/explore';
  static const String category = '/category';
}

class RouteNames {
  static const String splash = 'splash';
  static const String login = 'login';
  static const String home = 'home';
  static const String search = 'search';
  static const String explore = 'explore';
  static const String category = 'category';
  static const String profile = 'profile';
  static const String player = 'player';
}

/// 路由管理器
class RouterManager {
  static final RouterManager _instance = RouterManager._internal();
  factory RouterManager() => _instance;
  RouterManager._internal();

  final List<RouteConfig> _routes = [
    RouteConfig.page(
      path: RoutePaths.splash,
      name: RouteNames.splash,
      child: const HomeScreen(),
    ),
    RouteConfig.page(
      path: RoutePaths.login,
      name: RouteNames.login,
      child: const LoginScreen(),
    ),
    RouteConfig.page(
      path: RoutePaths.search,
      name: RouteNames.search,
      child: const SearchScreen(),
    ),
    RouteConfig.page(
      path: RoutePaths.home,
      name: RouteNames.home,
      child: const HomeScreen(),
      redirectToLogin: false,
    ),
    RouteConfig.page(
      path: RoutePaths.explore,
      name: RouteNames.explore,
      child: const ExploreScreen(),
      redirectToLogin: false,
    ),
    RouteConfig.page(
      path: RoutePaths.category,
      name: RouteNames.category,
      child: const CategoryScreen(),
      redirectToLogin: false,
    ),
    RouteConfig.page(
      path: RoutePaths.profile,
      name: RouteNames.profile,
      child: const ProfileScreen(),
      redirectToLogin: false,
    ),
    RouteConfig(
      path: RoutePaths.player,
      name: RouteNames.player,
      builder: (context, state) {
        final id = RouteParams.getParam(state, 'id');
        return PlayerPage(id: int.parse(id));
      },
    ),
  ];

  static String currentPage = RoutePaths.splash;

  Set<String> get _protectedPaths => _routes
      .where((route) => route.redirectToLogin)
      .map((route) => route.path)
      .toSet();

  String? _redirect(BuildContext context, GoRouterState state) {
    final authVm = GetIt.instance<AuthViewModel>();
    final isLoggedIn = authVm.user.value.value != null;
    final isGoingToLogin = state.uri.path == RoutePaths.login;

    // 已登录但尝试访问登录页
    if (isLoggedIn && isGoingToLogin) {
      return RoutePaths.home;
    }

    // 未登录且访问需要认证的页面
    if (!isLoggedIn && _requiresAuth(state)) {
      return RoutePaths.login;
    }

    return null;
  }

  bool _requiresAuth(GoRouterState state) {
    return _protectedPaths.contains(state.uri.path);
  }

  GoRoute _buildGoRoute(RouteConfig config) {
    return GoRoute(
      path: config.path,
      name: config.name.isNotEmpty ? config.name : null,
      builder: config.builder,
      routes: config.routes ?? [],
    );
  }

  /// 获取路由配置
  GoRouter get router {
    return GoRouter(
      initialLocation: RoutePaths.splash,
      routes: _routes.map(_buildGoRoute).toList(),
      redirect: _redirect,
      // 错误页面
      errorBuilder: (context, state) => const NotFoundPage(),
      // 页面过渡动画
      routerNeglect: false,
    );
  }

  /// 导航方法扩展
  static void pushNamed(
    BuildContext context,
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParams = const {},
    Object? extra,
  }) {
    context.pushNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParams,
      extra: extra,
    );
  }

  static void pushReplacementNamed(
    BuildContext context,
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParams = const {},
    Object? extra,
  }) {
    context.pushReplacementNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParams,
      extra: extra,
    );
  }

  static void pop(BuildContext context) {
    context.pop();
  }

  static void goNamed(
    BuildContext context,
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParams = const {},
    Object? extra,
  }) {
    context.goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParams,
      extra: extra,
    );
  }
}

/// 404页面
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('页面不存在')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: Colors.grey[600]),
            SizedBox(height: 20),
            Text('页面未找到', style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 10),
            Text(
              '您访问的页面可能已被移除或不存在',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go(RoutePaths.splash),
              child: Text('返回首页'),
            ),
          ],
        ),
      ),
    );
  }
}
