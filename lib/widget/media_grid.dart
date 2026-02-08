import 'package:flutter/material.dart';
import 'package:free_play_app/core/router/router_manager.dart';

/// 影视内容宫格组件（3列2行）
class MediaGrid extends StatelessWidget {
  /// 影视内容列表
  final List<MediaGridItem> mediaItems;

  /// 标题
  final String title;

  /// 跳转
  final String page;

  /// 点击回调
  final Function(MediaGridItem)? onTap;

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
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.6,
            ),
            itemCount: mediaItems.length > 6 ? 6 : mediaItems.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final media = mediaItems[index];
              return _MediaGridItem(media: media, onTap: onTap);
            },
          ),
        ],
      ),
    );
  }
}

/// 影视数据模型
class MediaGridItem {
  /// 标题
  final String title;

  /// 电影年份
  // final String year;

  /// 电影分类
  // final String type;

  /// 电影分类
  final String remark;

  /// 海报URL
  final String posterUrl;

  /// 评分
  final String rating;

  ///  媒体ID
  final int id;

  MediaGridItem({
    required this.title,
    // required this.year,
    // required this.type,
    required this.rating,
    required this.remark,
    required this.posterUrl,
    required this.id,
  });
}

/// 影视内容宫格项
class _MediaGridItem extends StatelessWidget {
  final MediaGridItem media;
  final Function(MediaGridItem)? onTap;

  const _MediaGridItem({required this.media, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                    right: 4,
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
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.white,
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
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
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
                    media.remark,
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
