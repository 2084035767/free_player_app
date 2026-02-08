import 'package:flutter/material.dart';
import 'package:free_play_app/core/theme/app_theme.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const String _githubUrl =
      'https://gitee.com/zs2084035767/free_player_app';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('关于'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(LineIcons.cat))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.movie,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        'Free Player',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineLarge?.copyWith(),
                      ),
                      IconButton(
                        onPressed: () => _launchUrl(_githubUrl, context),
                        icon: Icon(LineIcons.github),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '一个基础 flutter 构建的网络视频播放器',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('关于本项目'),
            const SizedBox(height: 12),
            _buildProjectDescription(
              '感谢您关注这个项目！这是一个面向 Flutter 进阶学习的实践项目。得益于我的前端开发背景，我在状态管理方案上做了一些非主流的技术选型与探索。项目整体架构简洁清晰，核心目标是帮助开发者快速搭建一个功能完备的网络视频播放器。',
            ),
            const SizedBox(height: 8),
            _buildProjectDescription(
              '希望这个项目能为同样在 Flutter 进阶路上探索的朋友提供一些启发和参考价值。',
            ),
            const SizedBox(height: 24),
            // 免责声明
            _buildSectionTitle('免责声明'),
            const SizedBox(height: 12),
            _buildSectionContent(
              '本应用为个人学习项目，不用于商业用途。应用“按现状”提供，可能存在未发现的缺陷，开发者不对使用过程中产生的任何损失负责。',
            ),
            TextButton(
              onPressed: () => _showFullDisclaimer(context),
              child: const Text(
                '查看完整免责声明',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 24),

            // 版本信息
            _buildKeyValueRow('Flutter 版本', '3.38.0', context),
            _buildKeyValueRow('最后更新', '2026年2月', context),
            const SizedBox(height: 32),
            // 致谢
            Center(
              child: Text(
                '© 2026 ZS. All rights reserved.',
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: .6),
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(content, style: TextStyle(height: 1.6));
  }

  Widget _buildProjectDescription(String content) {
    return Text(content, style: TextStyle(height: 1.8, fontSize: 15));
  }

  Widget _buildKeyValueRow(String key, String value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              key,
              style: TextStyle(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: .6),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url, BuildContext context) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('无法打开链接：$url')));
      }
    }
  }

  void _showFullDisclaimer(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppThemes.getCardColor(ctx),
        title: Text(
          '完整免责声明',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(),
        ),
        content: SingleChildScrollView(
          child: Text(
            '1. 本应用仅为个人学习与技术练习目的而开发，不用于任何商业用途。\n\n'
            '2. 应用可能存在未发现的缺陷、错误或不稳定情况，开发者不对应用的功能完整性、准确性或可靠性作任何明示或暗示的保证。\n\n'
            '3. 用户自愿使用本应用，因使用本应用所引发的任何直接或间接损失（包括但不限于数据丢失、设备损坏等），开发者概不负责。\n\n'
            '4. 本应用不收集用户个人信息，所有数据仅保存在用户设备本地。\n\n'
            '5. 应用中涉及的第三方库、API 或资源，其使用条款与隐私政策以原提供方为准。\n\n'
            '本应用“按现状”提供，开发者保留随时修改或终止应用的权利，恕不另行通知。',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('我已知晓'),
          ),
        ],
      ),
    );
  }
}
