import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('隐私政策'),
        centerTitle: true,
        elevation: 0, // 移除阴影更简洁
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 核心声明
            _buildSectionTitle('核心声明'),
            const SizedBox(height: 12),
            _buildSectionContent(
              '本应用是一个纯个人 Flutter 学习项目，不用于商业用途。'
              '我们不会收集、存储或传输您的任何个人信息。'
              '所有视频播放行为均在您设备本地完成。',
            ),
            const SizedBox(height: 24),

            // 数据收集
            _buildSectionTitle('数据收集'),
            const SizedBox(height: 14),
            _PrivacyItem(description: '不收集姓名、邮箱、电话等任何个人身份信息', isAllowed: false),
            _PrivacyItem(
              description: '不收集设备标识符、位置、通讯录、相册等敏感数据',
              isAllowed: false,
            ),
            _PrivacyItem(description: '不记录您播放的视频 URL 或观看历史', isAllowed: false),
            _PrivacyItem(
              description: '视频缓存仅保存在设备临时存储，退出后可能被清理',
              isAllowed: true,
            ),
            const SizedBox(height: 24),

            // 免责提示
            _DisclaimerBox(
              items: [
                '您播放的视频内容由 视频源提供方 控制，与本应用开发者无关。',
                '请勿使用本应用播放涉及版权或隐私风险的内容。',
                '本应用"按现状"提供，不承担因视频内容引发的任何责任。',
                '我们会生成一个匿名设备标识符用于区分用户，该标识符不包含您的个人身份信息.',
              ],
            ),

            // 底部间距，避免内容贴底
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

/// 章节标题组件
Widget _buildSectionTitle(String title) {
  return Text(
    title,
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );
}

/// 章节内容组件
Widget _buildSectionContent(String content) {
  return Text(content, style: TextStyle(height: 1.6));
}

/// 隐私条目组件（
class _PrivacyItem extends StatelessWidget {
  final String description;
  final bool isAllowed;

  const _PrivacyItem({required this.description, required this.isAllowed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            child: Icon(
              isAllowed ? LineIcons.checkCircle : LineIcons.timesCircle,
              size: 20,
              color: isAllowed ? Colors.green : colorScheme.error,
            ),
          ),
          const SizedBox(width: 12),
          // 内容区域
          Expanded(child: _buildSectionContent(description)),
        ],
      ),
    );
  }
}

/// 免责声明卡片组件
class _DisclaimerBox extends StatelessWidget {
  final List<String> items;

  const _DisclaimerBox({required this.items});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.1),
        border: Border.all(color: Colors.amber, width: 1),
        borderRadius: BorderRadius.circular(12), // 稍大一点更现代
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题行
          Row(
            children: [
              Icon(Icons.warning_amber, size: 20, color: Colors.amber),
              const SizedBox(width: 8),
              Text(
                '重要提示',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 列表内容
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items
                .map((item) => _buildListItem(item, colorScheme))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(String text, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(height: 1.6)),
          Expanded(child: _buildSectionContent(text)),
        ],
      ),
    );
  }
}
