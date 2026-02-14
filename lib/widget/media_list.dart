import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:free_play_app/widget/media_card.dart';

/// 视频列表组件
class MediaList extends StatelessWidget {
  /// 影视内容列表
  final List<Media> mediaItems;

  /// 标题
  final String title;

  /// 跳转
  final String page;

  /// 点击回调
  final Function(Media)? onTap;
  final double listHeight;
  final double itemWidth;

  const MediaList({
    super.key,
    required this.mediaItems,
    required this.title,
    required this.page,
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: listHeight,
            child: ListView.builder(
              shrinkWrap: true,
              itemExtent: 120,
              physics: const ClampingScrollPhysics(),
              itemCount: mediaItems.length,
              itemBuilder: (context, index) {
                final media = mediaItems[index];
                return SizedBox(
                  width: itemWidth,
                  child: MediaCard(media: media, onTap: onTap)
                      .animate()
                      .fadeIn(delay: (index * 80).ms, duration: 400.ms)
                      .slide(begin: const Offset(0.3, 0))
                      .scale(
                        begin: const Offset(0.95, 0.95),
                        end: const Offset(1.0, 1.0),
                      ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
