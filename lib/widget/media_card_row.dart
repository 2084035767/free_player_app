import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fox_player/widget/loading_card.dart';

/// 影视数据模型
class MediaRow {
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

  /// 简介内容
  final String content;

  MediaRow({
    required this.title,
    this.year,
    this.type,
    required this.rating,
    this.remark,
    required this.posterUrl,
    required this.id,
    required this.content,
  });
}

class MediaCardRow extends StatelessWidget {
  final MediaRow media;
  final Function(MediaRow)? onTap;
  const MediaCardRow({super.key, required this.media, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onTap?.call(media),
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            // 左边 - 封面
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(8),
              ),
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
            // 右边 - 信息
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 标题
                    Text(
                      media.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // 简介
                    Expanded(
                      child: Text(
                        media.content,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // 年份、类型和评分
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            media.remark ?? '${media.year} · ${media.type}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(155, 175, 248, 218),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            media.rating,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
