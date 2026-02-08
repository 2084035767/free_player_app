import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpFeedbackPage extends StatelessWidget {
  const HelpFeedbackPage({super.key});

  static const String _githubUrl =
      'https://github.com/yourname/video_player_lab';
  static const String _issuesUrl = '$_githubUrl/issues';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('帮助与反馈'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 常见问题
            _buildSectionTitle('❓ 常见问题', context),
            const SizedBox(height: 12),
            _buildFAQItem(
              '视频无法播放？',
              '请检查：① URL 是否有效且可公开访问 ② 视频格式是否为 MP4/HLS ③ 设备网络是否正常。本播放器不支持 DRM 保护内容。',
              context,
            ),
            _buildFAQItem(
              '播放卡顿/缓冲慢？',
              '此为网络视频正常现象，取决于视频源服务器带宽与您的网络环境。应用本身不进行额外缓冲优化（练习项目定位）。',
              context,
            ),
            _buildFAQItem(
              '为什么没有“下载视频”功能？',
              '本项目聚焦播放器核心能力实现，未集成下载模块。如需学习下载实现，可参考 dio + path_provider 插件方案。',
              context,
            ),
            _buildFAQItem(
              '会收集我的播放记录吗？',
              '❌ 不会。所有操作仅在设备本地完成，无任何数据上传行为。详见「隐私政策」页面。',
              context,
            ),
            const SizedBox(height: 28),

            // 反馈渠道
            _buildSectionTitle('📮 反馈渠道', context),
            _buildFeedbackCard(
              Icons.bug_report,
              '报告问题',
              '遇到 Bug 或异常行为？请通过 GitHub Issues 提交详细描述与复现步骤',
              () => _launchUrl(_issuesUrl, context),
              context,
            ),
            const SizedBox(height: 12),
            _buildFeedbackCard(
              Icons.lightbulb_outline,
              '功能建议',
              '有好的想法？欢迎提交 Feature Request，我会在学习过程中评估实现',
              () => _launchUrl(_issuesUrl, context),
              context,
            ),
            const SizedBox(height: 12),
            _buildFeedbackCard(
              Icons.code,
              '参与贡献',
              '发现代码问题或优化点？欢迎 Fork 仓库并提交 Pull Request',
              () => _launchUrl(_githubUrl, context),
              context,
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                '💡 提示：作为个人练习项目，反馈回复可能不及时，敬请谅解',
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: .6),
                ),
              ),
            ),
            const SizedBox(height: 28),
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

  Widget _buildFAQItem(String question, String answer, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q: $question',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'A: $answer',
            style: TextStyle(
              height: 1.6,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: .8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackCard(
    IconData icon,
    String title,
    String description,
    VoidCallback onPressed,
    BuildContext context,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: .1),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  size: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        height: 1.4,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: .7),
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
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
}
