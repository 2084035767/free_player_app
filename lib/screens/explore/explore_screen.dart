import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:free_play_app/core/router/router_manager.dart';
import 'package:free_play_app/di/service_locator.dart';
import 'package:free_play_app/services/video_service.dart';
import 'package:free_play_app/widget/error_text.dart';
import 'package:free_play_app/widget/loading_indicator.dart';
import 'package:free_play_app/widget/media_card.dart';
import 'package:free_play_app/widget/media_scroll.dart';
import 'package:free_play_app/widget/popular_categories_grid.dart';
import 'package:signals_hooks/signals_hooks.dart';

class ExploreScreen extends HookWidget {
  const ExploreScreen({super.key});

  static final List<CategoryItem> _categories = [
    CategoryItem(id: 11, title: '电影', icon: Icons.movie, color: Colors.red),
    CategoryItem(id: 3, title: '剧集', icon: Icons.tv, color: Colors.blue),
    CategoryItem(
      id: 27,
      title: '综艺',
      icon: Icons.music_note,
      color: Colors.green,
    ),
    CategoryItem(
      id: 25,
      title: '动漫',
      icon: Icons.auto_awesome,
      color: Colors.orange,
    ),
    CategoryItem(
      id: 16,
      title: '纪录片',
      icon: Icons.video_library,
      color: Colors.purple,
    ),
    CategoryItem(
      id: 30,
      title: '短剧',
      icon: Icons.play_arrow,
      color: Colors.indigo,
    ),
    CategoryItem(
      id: 29,
      title: '体育',
      icon: Icons.sports,
      color: const Color.fromARGB(255, 181, 63, 171),
    ),
    CategoryItem(
      id: 31,
      title: '更多',
      icon: Icons.more_horiz,
      color: const Color.fromARGB(255, 147, 76, 234),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final vs = useMemoized(() => getIt<VideoService>());
    final show = useFutureSignal(() => vs.fetchShow());
    final movies = useFutureSignal(() => vs.fetchMovies());
    final tv = useFutureSignal(() => vs.fetchTv());
    return Scaffold(
      appBar: AppBar(
        title: const Text('发现'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              RouterManager.pushNamed(context, RouteNames.search);
            },
          ),
        ],
      ),
      body: Watch.builder(
        builder: (context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PopularCategoriesGrid(
                  title: '探索分类',
                  categories: _categories,
                  onTap: (category) {
                    RouterManager.pushNamed(
                      context,
                      RouteNames.custom,
                      pathParameters: {'id': category.id.toString()},
                    );
                  },
                ),
                switch (movies.value) {
                  AsyncData(value: final videos) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 热门分类
                      MediaScroll(
                        mediaItems: videos.map((video) {
                          return Media(
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
                    ],
                  ),
                  AsyncLoading() => const Center(child: LoadingIndicator()),
                  AsyncError(error: final error) => ErrorText(error: error),
                },
                const SizedBox(height: 20),
                switch (tv.value) {
                  AsyncData(value: final videos) => MediaScroll(
                    mediaItems: videos.map((video) {
                      return Media(
                        id: video.vodId,
                        title: video.vodName,
                        posterUrl: video.vodPic,
                        year: video.vodYear,
                        type: video.typeName,
                        rating: video.vodDoubanScore,
                      );
                    }).toList(),
                    title: '剧集',
                    page: 'page',
                    onTap: (video) {
                      RouterManager.pushNamed(
                        context,
                        RouteNames.player,
                        pathParameters: {'id': video.id.toString()},
                      );
                    },
                  ),
                  AsyncLoading() => const Center(child: LoadingIndicator()),
                  AsyncError(error: final error) => ErrorText(error: error),
                },
                const SizedBox(height: 20),
                switch (show.value) {
                  AsyncData(value: final videos) => MediaScroll(
                    mediaItems: videos.map((video) {
                      return Media(
                        id: video.vodId,
                        title: video.vodName,
                        posterUrl: video.vodPic,
                        year: video.vodYear,
                        type: video.typeName,
                        rating: video.vodDoubanScore,
                      );
                    }).toList(),
                    title: '综艺',
                    page: 'page',
                    onTap: (video) {
                      RouterManager.pushNamed(
                        context,
                        RouteNames.player,
                        pathParameters: {'id': video.id.toString()},
                      );
                    },
                  ),
                  AsyncLoading() => const Center(child: LoadingIndicator()),
                  AsyncError(error: final error) => ErrorText(error: error),
                },
              ],
            ),
          );
        },
      ),
    );
  }
}
