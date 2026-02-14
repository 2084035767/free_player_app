import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:free_play_app/widget/loading_card.dart';

/// 影视数据模型
class Media {
  /// 标题
  final String title;

  /// 电影年份
  final String? year;

  /// 电影分类
  final String? type;

  /// 电影分类
  final String? remark;

  /// 海报URL
  final String posterUrl;

  /// 评分
  final String rating;

  ///  媒体ID
  final int id;

  Media({
    required this.title,
    this.year,
    this.type,
    required this.rating,
    this.remark,
    required this.posterUrl,
    required this.id,
  });
}

class MediaCard extends StatelessWidget {
  final Media media;
  final Function(Media)? onTap;

  const MediaCard({super.key, required this.media, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardRadius = BorderRadius.circular(8);

    return GestureDetector(
      onTap: () => onTap?.call(media),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Center(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: cardRadius,
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: CachedNetworkImage(
                        imageUrl: media.posterUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[200],
                          child: const Center(child: LoadingCard()),
                        ),
                      ),
                    ),
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
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    textAlign: .left,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    media.remark ?? '${media.year} · ${media.type}',
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: .left,
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
