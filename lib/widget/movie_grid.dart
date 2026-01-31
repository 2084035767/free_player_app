import 'package:flutter/material.dart';

/// 电影推荐宫格组件（4宫格）
class MovieGrid extends StatelessWidget {
  /// 电影列表
  final List<MovieItem> movies;

  /// 点击回调
  final Function(MovieItem)? onTap;

  const MovieGrid({super.key, required this.movies, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '电影推荐',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(movies.length > 4 ? 4 : movies.length, (
              index,
            ) {
              final movie = movies[index];
              return _MovieGridItem(movie: movie, onTap: onTap);
            }),
          ),
        ],
      ),
    );
  }
}

/// 电影宫格项
class _MovieGridItem extends StatelessWidget {
  final MovieItem movie;
  final Function(MovieItem)? onTap;

  const _MovieGridItem({required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(movie),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: .2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 电影海报
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      movie.posterUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.movie, color: Colors.grey),
                        );
                      },
                    ),
                    // 评分标签
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          movie.rating.toString(),
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
            // 电影信息
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${movie.year.toString()} · ${movie.type}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 电影数据模型
class MovieItem {
  /// 电影标题
  final String title;

  /// 电影年份
  final int year;

  /// 电影分类
  final String type;

  /// 海报URL
  final String posterUrl;

  /// 评分
  final double rating;

  MovieItem({
    required this.title,
    required this.year,
    required this.type,
    required this.posterUrl,
    required this.rating,
  });
}
