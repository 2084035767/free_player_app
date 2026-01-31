import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:free_play_app/core/router/router_manager.dart';
import 'package:free_play_app/di/service_locator.dart';
import 'package:free_play_app/services/video_service.dart';
import 'package:free_play_app/widget/media_scroll.dart';
import 'package:free_play_app/widget/popular_categories_grid.dart';
import 'package:signals_hooks/signals_hooks.dart';

class ExploreScreen extends HookWidget {
  const ExploreScreen({super.key});

  // 创建示例分类数据
  static final List<CategoryItem> _categories = [
    CategoryItem(title: '电影', icon: Icons.movie, color: Colors.red),
    CategoryItem(title: '电视剧', icon: Icons.tv, color: Colors.blue),
    CategoryItem(title: '综艺', icon: Icons.music_note, color: Colors.green),
    CategoryItem(title: '动漫', icon: Icons.auto_awesome, color: Colors.orange),
    CategoryItem(title: '纪录片', icon: Icons.video_library, color: Colors.purple),
    CategoryItem(title: '短剧', icon: Icons.play_arrow, color: Colors.indigo),
    CategoryItem(
      title: '体育',
      icon: Icons.sports,
      color: const Color.fromARGB(255, 181, 63, 171),
    ),
    CategoryItem(
      title: '更多',
      icon: Icons.more_horiz,
      color: const Color.fromARGB(255, 147, 76, 234),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final vs = useMemoized(() => getIt<VideoService>());
    final popular = useFutureSignal(() => vs.fetchPopular());
    return Scaffold(
      appBar: AppBar(
        title: const Text('发现'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('功能待开发')));
            },
          ),
        ],
      ),
      body: Watch.builder(
        builder: (context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: switch (popular.value) {
              AsyncData(value: final videos) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 热门分类
                  PopularCategoriesGrid(
                    title: '探索分类',
                    categories: _categories,
                    onTap: (category) {
                      // TODO: 处理分类点击事件
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('点击了分类: ${category.title}')),
                      );
                    },
                  ),
                  MediaScroll(
                    mediaItems: videos.map((video) {
                      return MediaScrollItem(
                        id: video.vodId,
                        title: video.vodName,
                        posterUrl: video.vodPic,
                        year: video.vodYear,
                        type: video.typeName,
                        rating: video.vodDoubanScore,
                      );
                    }).toList(),
                    title: '电影',
                    page: 'page',
                    onTap: (video) {
                      RouterManager.pushNamed(
                        context,
                        RouteNames.player,
                        pathParameters: {'id': video.id.toString()},
                      );
                    },
                  ),
                  MediaScroll(
                    mediaItems: videos.map((video) {
                      return MediaScrollItem(
                        id: video.vodId,
                        title: video.vodName,
                        posterUrl: video.vodPic,
                        year: video.vodYear,
                        type: video.typeName,
                        rating: video.vodDoubanScore,
                      );
                    }).toList(),
                    title: '电影',
                    page: 'page',
                    onTap: (video) {
                      RouterManager.pushNamed(
                        context,
                        RouteNames.player,
                        pathParameters: {'id': video.id.toString()},
                      );
                    },
                  ),
                  MediaScroll(
                    mediaItems: videos.map((video) {
                      return MediaScrollItem(
                        id: video.vodId,
                        title: video.vodName,
                        posterUrl: video.vodPic,
                        year: video.vodYear,
                        type: video.typeName,
                        rating: video.vodDoubanScore,
                      );
                    }).toList(),
                    title: '电影',
                    page: 'page',
                    onTap: (video) {
                      RouterManager.pushNamed(
                        context,
                        RouteNames.player,
                        pathParameters: {'id': video.id.toString()},
                      );
                    },
                  ),

                  // 电影分类
                  const SizedBox(height: 20),
                ],
              ),
              AsyncLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              AsyncError(error: final error) => Text(
                'Error: ${error.toString()}',
              ),
            },
          );
        },
      ),
    );
  }
}
