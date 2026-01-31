import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:free_play_app/core/router/router_manager.dart';
import 'package:free_play_app/di/service_locator.dart';
import 'package:free_play_app/services/video_service.dart';
import 'package:free_play_app/widget/media_page.dart';
import 'package:free_play_app/widget/top_tab_bar.dart';
import 'package:signals_hooks/signals_hooks.dart';

class CategoryScreen extends HookWidget {
  const CategoryScreen({super.key});
  static const _tabItems = [
    TopTabBarItem(title: '推荐'),
    TopTabBarItem(title: '电影'),
    TopTabBarItem(title: '剧集'),
    TopTabBarItem(title: '综艺'),
    TopTabBarItem(title: '动漫'),
    TopTabBarItem(title: '记录'),
  ];
  @override
  Widget build(BuildContext context) {
    final homeTabIndex = useSignal<int>(0);
    final vs = useMemoized(() => getIt<VideoService>());
    final popular = useFutureSignal(
      () => vs.fetchCategory(homeTabIndex.value),
      dependencies: [homeTabIndex],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('分类'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('功能待开发')));
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: TopTabBar(
            items: _tabItems,
            selectedIndex: homeTabIndex.value,
            onTap: (index) => homeTabIndex.value = index,
            backgroundColor:
                Theme.of(context).appBarTheme.backgroundColor ?? Colors.white,
          ),
        ),
      ),
      body: Watch.builder(
        builder: (context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: switch (popular.value) {
              AsyncData(value: final videos) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 电影榜单
                  MediaPage(
                    mediaItems: videos.map((video) {
                      return MediaPageItem(
                        id: video.vodId,
                        title: video.vodName,
                        posterUrl: video.vodPic,
                        year: video.vodYear,
                        type: video.typeName,
                        rating: video.vodDoubanScore, // 使用实际的海报URL
                      );
                    }).toList(),
                    onTap: (video) {
                      RouterManager.pushNamed(
                        context,
                        RouteNames.player,
                        pathParameters: {'id': video.id.toString()},
                      );
                    },
                  ),
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
