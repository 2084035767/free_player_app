import 'package:flutter/material.dart';
import 'package:free_play_app/core/router/router_manager.dart';

/// 影视内容列表组件（横行）
class MediaScroll extends StatelessWidget {
  /// 影视内容列表
  final List<MediaScrollItem> mediaItems;

  /// 标题
  final String title;

  /// 跳转
  final String page;

  /// 点击回调
  final Function(MediaScrollItem)? onTap;
  final double listHeight;
  final double itemWidth;

  const MediaScroll({
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
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => RouterManager.goNamed(context, page),
                child: const Text(
                  "更多",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.lightBlue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: listHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: mediaItems.length,
              itemBuilder: (context, index) {
                final media = mediaItems[index];
                return SizedBox(
                  width: itemWidth,
                  child: _MediaScrollItem(media: media, onTap: onTap),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 影视数据模型
class MediaScrollItem {
  /// 标题
  final String title;

  /// 电影年份
  final String year;

  /// 电影分类
  final String type;

  /// 海报URL
  final String posterUrl;

  /// 评分
  final String rating;

  ///  媒体ID
  final int id;

  MediaScrollItem({
    required this.title,
    required this.year,
    required this.type,
    required this.rating,
    required this.posterUrl,
    required this.id,
  });
}

/// 影视内容宫格项
class _MediaScrollItem extends StatelessWidget {
  final MediaScrollItem media;
  final Function(MediaScrollItem)? onTap;

  const _MediaScrollItem({required this.media, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(media),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 1,
                  right: 1,
                  top: 8,
                  bottom: 0,
                ),

                child: Center(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                    child: Image.network(
                      media.posterUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.movie, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            // 影视信息 - 这里只包含文本内容
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  top: 2,
                  bottom: 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      media.title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left, // 确保文本内容左对齐
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${media.year} · ${media.type} · ${media.rating}',
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left, // 确保文本内容左对齐
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
