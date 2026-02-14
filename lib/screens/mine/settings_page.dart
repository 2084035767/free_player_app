import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:free_play_app/core/app_config.dart';
import 'package:free_play_app/core/theme/app_theme.dart';
import 'package:free_play_app/di/service_locator.dart';
import 'package:line_icons/line_icons.dart';
import 'package:signals_hooks/signals_hooks.dart';

class SettingsPage extends HookWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appConfig = getIt<AppConfig>();
    final notificationsEnabled = useSignal<bool>(true);
    final autoPlayEnabled = useSignal<bool>(true);
    final videoQuality = useSignal<String>('高清');
    final downloadQuality = useSignal<String>('高清');
    // final darkModeEnabled = useSignal<bool>(false);
    var darkModeEnabled = appConfig.themeMode.value == AppThemeMode.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('设置'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 账户与隐私设置
          _buildSectionTitle('账户设置'),
          _buildSettingItem(
            icon: Icons.security,
            title: '账号安全',
            subtitle: '修改密码、绑定手机号',
            onTap: () {
              _showInfoDialog('账号安全', '此功能正在开发中', context);
            },
          ),
          const SizedBox(height: 20),

          // 播放设置
          _buildSectionTitle('播放设置'),
          _buildSwitchItem(
            icon: Icons.notifications,
            title: '消息通知',
            value: notificationsEnabled.value,
            onChanged: (value) {
              notificationsEnabled.value = value;
            },
          ),
          _buildSwitchItem(
            icon: Icons.play_circle,
            title: '自动播放',
            value: autoPlayEnabled.value,
            onChanged: (value) {
              autoPlayEnabled.value = value;
            },
          ),
          _buildDropdownItem(
            icon: Icons.hd,
            title: '视频清晰度',
            value: videoQuality.value,
            items: ['流畅', '标清', '高清', '超清'],
            onChanged: (String? newValue) {
              if (newValue != null) {
                videoQuality.value = newValue;
              }
            },
          ),
          const SizedBox(height: 20),

          // 下载设置
          _buildSectionTitle('下载设置'),
          _buildDropdownItem(
            icon: Icons.download,
            title: '下载清晰度',
            value: downloadQuality.value,
            items: ['流畅', '标清', '高清'],
            onChanged: (String? newValue) {
              if (newValue != null) {
                downloadQuality.value = newValue;
              }
            },
          ),
          _buildSettingItem(
            icon: Icons.storage,
            title: '清除缓存',
            subtitle: '释放存储空间',
            onTap: () {
              _showClearCacheDialog(context);
            },
          ),
          const SizedBox(height: 20),

          // 外观设置
          _buildSectionTitle('外观设置'),
          _buildSwitchItem(
            icon: Icons.dark_mode,
            title: '深色模式',
            value: darkModeEnabled,
            onChanged: (value) {
              darkModeEnabled = value;
              // 更新全局主题设置
              final newThemeMode = value
                  ? AppThemeMode.dark
                  : AppThemeMode.light;
              appConfig.setThemeMode(newThemeMode);
            },
          ),
          _buildSettingItem(
            icon: Icons.language,
            title: '语言设置',
            subtitle: '简体中文',
            onTap: () {
              _showInfoDialog('语言设置', '语言选择功能正在开发中', context);
            },
          ),
          const SizedBox(height: 20),

          // 关于应用
          _buildSectionTitle('关于应用'),
          _buildSettingItem(
            icon: Icons.info,
            title: '关于我们',
            subtitle: '了解应用信息',
            onTap: () {
              Navigator.of(context).pushNamed('/about');
            },
          ),
          _buildSettingItem(
            icon: Icons.rate_review,
            title: '评分鼓励',
            subtitle: '给应用打分',
            onTap: () {
              _showInfoDialog('评分鼓励', '感谢您的支持！', context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppThemes.primaryGray,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppThemes.primaryGray.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppThemes.primaryGray),
        ),
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: Icon(LineIcons.angleRight, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SwitchListTile(
        activeThumbColor: AppThemes.primaryGray,
        inactiveThumbColor: AppThemes.darkGray,
        inactiveTrackColor: AppThemes.darkPrimaryGray,
        secondary: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppThemes.primaryGray.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppThemes.primaryGray),
        ),
        title: Text(title),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDropdownItem({
    required IconData icon,
    required String title,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppThemes.primaryGray.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppThemes.primaryGray),
            ),
            const SizedBox(width: 16),
            Expanded(child: Text(title)),
            DropdownButton<String>(
              value: value,
              underline: Container(),
              items: items.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }

  void _showInfoDialog(String title, String content, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppThemes.getCardColor(context),
          title: Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(),
          ),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppThemes.getCardColor(context),
          title: const Text('清除缓存'),
          content: const Text('确定要清除所有缓存数据吗？这将释放约 25.6 MB 的存储空间。'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                // 实际的清除缓存逻辑
                _showInfoDialog('提示', '缓存已成功清除', context);
                Navigator.of(context).pop();
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }
}
