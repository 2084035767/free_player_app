import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('隐私政策'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 核心声明
            _buildSectionTitle('📌 核心声明', context),
            _buildSectionContent(
              '本应用是一个纯个人 Flutter 学习项目，不用于商业用途。我们不会收集、存储或传输您的任何个人信息。所有视频播放行为均在您设备本地完成。',
              context,
            ),
            const SizedBox(height: 24),

            // 数据收集
            _buildSectionTitle('🔒 数据收集', context),
            const SizedBox(height: 12),
            _buildPrivacyItem('个人信息', '❌ 不收集姓名、邮箱、电话等任何个人身份信息', context),
            _buildPrivacyItem('设备数据', '❌ 不收集设备标识符、位置、通讯录、相册等敏感数据', context),
            _buildPrivacyItem('播放记录', '❌ 不记录您播放的视频 URL 或观看历史', context),
            _buildPrivacyItem(
              '本地缓存',
              '✅ 视频缓存仅保存在设备临时存储，应用退出后可能被系统自动清理',
              context,
            ),
            const SizedBox(height: 24),

            // 免责提示
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: .1),
                border: Border.all(color: Colors.amber, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning_amber, size: 20, color: Colors.amber),
                      const SizedBox(width: 8),
                      const Text(
                        '重要提示',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: '• 您播放的视频内容由 '),
                        TextSpan(
                          text: '视频源提供方',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const TextSpan(text: ' 控制，与本应用开发者无关。\n'),
                        const TextSpan(text: '• 请勿使用本应用播放涉及版权或隐私风险的内容。\n'),
                        const TextSpan(text: '• 本应用“按现状”提供，不承担因视频内容引发的任何责任。'),
                      ],
                      style: TextStyle(
                        height: 1.6,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: .8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _buildSectionContent(String content, BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        height: 1.6,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: .8),
      ),
    );
  }

  Widget _buildPrivacyItem(
    String title,
    String description,
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            child: Icon(
              description.startsWith('✅') ? Icons.check_circle : Icons.cancel,
              size: 18,
              color: description.startsWith('✅')
                  ? Colors.green
                  : Theme.of(context).colorScheme.error,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    height: 1.5,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: .8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
