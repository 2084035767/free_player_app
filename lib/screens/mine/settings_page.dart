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
    var darkModeEnabled = appConfig.themeMode.value == AppThemeMode.dark;
    return Scaffold(
      appBar: AppBar(title: const Text('设置'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
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
          _buildSettingItem(
            context: context,
            icon: Icons.language,
            title: '订阅设置',
            onTap: () {},
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
            context: context,
            icon: Icons.language,
            title: '语言设置',
            subtitle: '简体中文',
            onTap: () {
              _showInfoDialog('语言设置', '语言选择功能正在开发中', context);
            },
          ),
          const SizedBox(height: 20),

          _buildSectionTitle('关于应用'),
          _buildSettingItem(
            context: context,
            icon: Icons.info,
            title: '关于我',
            subtitle: '本应用的开发者',
            onTap: () {
              _showInfoDialog('关于我', '子十 · 一个正在进步的开发者', context);
            },
          ),
          _buildSettingItem(
            context: context,
            icon: Icons.rate_review,
            title: '评分鼓励',
            subtitle: '给应用打分',
            onTap: () {
              _showInfoDialog('评分鼓励', '感谢您的支持！', context);
            },
          ),
          _buildTextTextItem(
            icon: Icons.wind_power,
            title: "当前版本",
            context: context,
            text: "1.0.0",
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required BuildContext context,
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
        title: Text(
          title,
          style: TextStyle(color: AppThemes.getPrimaryTextColor(context)),
        ),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: Icon(LineIcons.angleRight, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildTextTextItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required BuildContext context,
    required String text,
    // required VoidCallback onTap,
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
        title: Text(
          title,
          style: TextStyle(color: AppThemes.getPrimaryTextColor(context)),
        ),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: Text(text, style: TextStyle(fontWeight: .w700)),
      ),
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    double switchScale = 0.75,
  }) {
    return Card(
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
        trailing: Transform.scale(
          scale: switchScale,
          child: Switch(
            value: value,
            onChanged: onChanged,
            thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.selected)) {
                return AppThemes.primaryGray;
              }
              return AppThemes.darkGray;
            }),
            trackColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.selected)) {
                return AppThemes.primaryGray.withValues(alpha: 0.5);
              }
              return AppThemes.darkPrimaryGray;
            }),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        onTap: () => onChanged(!value),
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
              child: Text(
                '确定',
                style: TextStyle(
                  color: AppThemes.getSecondaryTextColor(context),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
