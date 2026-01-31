import 'package:flutter/material.dart';
import 'package:free_play_app/core/app_config.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final mode = appConfig.themeMode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        actions: [
          IconButton(
            icon: mode.value == AppThemeMode.dark
                ? const Icon(Icons.sunny)
                : const Icon(Icons.nights_stay),
            onPressed: () {
              mode.value == AppThemeMode.dark
                  ? AppThemeMode.light
                  : AppThemeMode.dark;
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
                    backgroundImage: NetworkImage(
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
                // TODO: 跳转到帮助与反馈页面
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('帮助与反馈功能待开发')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip, color: Colors.grey),
              title: const Text('隐私政策'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: 跳转到隐私政策页面
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('隐私政策功能待开发')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.grey),
              title: const Text('关于我'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TODO: 跳转到关于我页面
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('关于我功能待开发')));
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
