import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:free_play_app/core/router/router_manager.dart';
import 'package:free_play_app/widget/media_card.dart';

/// 影视内容宫格组件（3列2行）
class MediaGrid extends StatelessWidget {
  /// 影视内容列表
  final List<Media> mediaItems;

  /// 标题
  final String title;

  /// 跳转
  final String page;

  /// 点击回调
  final Function(Media)? onTap;

  const MediaGrid({
    super.key,
    required this.mediaItems,
    required this.title,
    required this.page,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (mediaItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(title, style: theme.textTheme.titleLarge?.copyWith()),
              TextButton(
                onPressed: () => RouterManager.goNamed(context, page),
                child: Text(
                  "更多",
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 6,
              mainAxisSpacing: 12,
              childAspectRatio: 2 / 3,
            ),
            itemCount: mediaItems.length > 6 ? 6 : mediaItems.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final media = mediaItems[index];
              return MediaCard(media: media, onTap: onTap)
                  .animate()
                  .fadeIn(delay: (index * 80).ms, duration: 400.ms)
                  .slide(begin: const Offset(0, 0.3))
                  .scale(
                    begin: const Offset(0.95, 0.95),
                    end: const Offset(1.0, 1.0),
                  );
            },
          ),
        ],
      ),
    );
  }
}



/// 影视内容宫格项

