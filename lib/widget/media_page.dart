import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:free_play_app/widget/media_card.dart';

/// 影视内容宫格组件（3列2行）
class MediaPage extends StatelessWidget {
  /// 影视内容列表
  final List<Media> mediaItems;
  final EasyRefreshController controller;

  /// 点击回调
  final Function(Media)? onTap;
  final Function() refresh;
  final Function() load;

  const MediaPage({
    super.key,
    required this.mediaItems,
    this.onTap,
    required this.controller,
    required this.refresh,
    required this.load,
  });

  @override
  Widget build(BuildContext context) {
    if (mediaItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return EasyRefresh(
      onRefresh: () async {
        refresh();
        controller.finishRefresh();
        controller.resetFooter();
      },
      onLoad: () async {
        load();
        controller.finishLoad(IndicatorResult.noMore);
      },
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 6,
          mainAxisSpacing: 12,
          childAspectRatio: 2 / 3,
        ),
        itemCount: mediaItems.length,
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
    );
  }
}
