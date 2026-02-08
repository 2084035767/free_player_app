import 'package:flutter/material.dart';

/// 影视内容宫格组件（3列2行）
class MediaPage extends StatelessWidget {
  /// 影视内容列表
  final List<MediaPageItem> mediaItems;

  /// 点击回调
  final Function(MediaPageItem)? onTap;

  const MediaPage({super.key, required this.mediaItems, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (mediaItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.6,
      ),
      itemCount: mediaItems.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final media = mediaItems[index];
        return _MediaPageItem(media: media, onTap: onTap);
      },
    );
  }
}

/// 影视数据模型
class MediaPageItem {
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

  MediaPageItem({
    required this.title,
    required this.year,
    required this.type,
    required this.rating,
    required this.posterUrl,
    required this.id,
  });
}

/// 影视内容宫格项
class _MediaPageItem extends StatelessWidget {
  final MediaPageItem media;
  final Function(MediaPageItem)? onTap;

  const _MediaPageItem({required this.media, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cardRadius = BorderRadius.circular(8);
    return GestureDetector(
      onTap: () => onTap?.call(media),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Center(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: cardRadius,
                    child: Image.network(media.posterUrl),
                  ),
                  // 评分标签
                  Positioned(
                    top: 0,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(128, 175, 226, 248),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        media.rating,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    media.title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${media.year} · ${media.type}',
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
