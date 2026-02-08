import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:free_play_app/core/app_config.dart';
import 'package:free_play_app/core/router/router_manager.dart';
import 'package:free_play_app/di/service_locator.dart';
import 'package:signals_hooks/signals_hooks.dart';

class ProfileScreen extends HookWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appConfig = useMemoized(() => getIt<AppConfig>());
    final mode = useExistingSignal(appConfig.themeMode);
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        actions: [
          IconButton(
            icon: Icon(mode.value.iconData),
            onPressed: () {
              final newMode = mode.value.toggled;
              mode.value = newMode;
              appConfig.setThemeMode(mode.value);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            // 用户信息区域
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // 用户头像
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: CachedNetworkImageProvider(
                      'https://img.cdn1.vip/i/6975dea5ddb59_1769332389.webp',
                    ),
                  ),
                  const SizedBox(width: 20),
                  // 用户信息
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '小橙子',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '用户ID: 123456',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "12",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "观看历史",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "45",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "我的收藏",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "59",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "我的下载",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // 功能列表
            ListTile(
              leading: const Icon(Icons.history, color: Colors.blue),
              title: const Text('观看历史'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: 跳转到观看历史页面
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('观看历史功能待开发')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.red),
              title: const Text('我的收藏'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: 跳转到收藏页面
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('我的收藏功能待开发')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.download, color: Colors.grey),
              title: const Text('我的下载'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: 跳转到下载页面
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('我的下载功能待开发')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_time, color: Colors.orange),
              title: const Text('稍后观看'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: 跳转到稍后观看页面
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('稍后观看功能待开发')));
              },
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.grey),
              title: const Text('设置'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: 跳转到设置页面
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('设置功能待开发')));
              },
            ),

            ListTile(
              leading: const Icon(Icons.help, color: Colors.grey),
              title: const Text('帮助与反馈'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                RouterManager.pushNamed(context, RouteNames.help);
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip, color: Colors.grey),
              title: const Text('隐私政策'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                RouterManager.pushNamed(context, RouteNames.privacy);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.grey),
              title: const Text('关于我'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                RouterManager.pushNamed(context, RouteNames.about);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
