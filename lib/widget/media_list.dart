import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fox_player/widget/media_card_row.dart';

/// 视频列表组件
class MediaList extends StatelessWidget {
  /// 影视内容列表
  final List<MediaRow> mediaItems;

  /// 点击回调
  final Function(MediaRow)? onTap;
  final double listHeight;
  final double itemWidth;

  const MediaList({
    super.key,
    required this.mediaItems,
    this.onTap,
    this.listHeight = 220,
    this.itemWidth = 140,
  });

  @override
  Widget build(BuildContext context) {
    if (mediaItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          SizedBox(
            height: listHeight,
            child: ListView.builder(
              itemExtent: 120,
              physics: const ClampingScrollPhysics(),
              itemCount: mediaItems.length,
              itemBuilder: (context, index) {
                final media = mediaItems[index];
                return MediaCardRow(media: media, onTap: onTap)
                    .animate()
                    .fadeIn(delay: (index * 80).ms, duration: 400.ms)
                    .slide(begin: const Offset(0.3, 0))
                    .scale(
                      begin: const Offset(0.95, 0.95),
                      end: const Offset(1.0, 1.0),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
