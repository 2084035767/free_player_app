import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:free_play_app/core/router/router_manager.dart';
import 'package:free_play_app/di/service_locator.dart';
import 'package:free_play_app/services/video_service.dart';
import 'package:free_play_app/widget/error_page.dart';
import 'package:free_play_app/widget/loading_indicator.dart';
import 'package:free_play_app/widget/media_card.dart';
import 'package:free_play_app/widget/media_page.dart';
import 'package:signals_hooks/signals_hooks.dart';

class CategoryScreen extends HookWidget {
  const CategoryScreen({super.key});

  static const _tabItems = [
    Tab(text: '电影'),
    Tab(text: '剧集'),
    Tab(text: '综艺'),
    Tab(text: '动漫'),
    Tab(text: '短剧'),
  ];

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: _tabItems.length);
    final vs = useMemoized(() => getIt<VideoService>());

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
        bottom: TabBar(controller: tabController, tabs: _tabItems),
      ),
      body: TabBarView(
        controller: tabController,
        children: List.generate(
          _tabItems.length,
          (index) => _CategoryTabPage(
            index: index,
            videoService: vs,
            key: ValueKey(index),
          ),
        ),
      ),
    );
  }
}

class _CategoryTabPage extends HookWidget {
  final int index;
  final VideoService videoService;

  const _CategoryTabPage({
    required this.index,
    required this.videoService,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryId = switch (index) {
      0 => 11,
      1 => 3,
      2 => 27,
      3 => 25,
      4 => 30,
      _ => 0,
    };
    final category = useFutureSignal(
      () => videoService.fetchCategory(categoryId),
    );
    EasyRefreshController controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
    return switch (category.value) {
      AsyncData(value: final videos) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MediaPage(
              refresh: () {},
              load: () {},
              controller: controller,
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
      ),
      AsyncLoading() => const Center(child: LoadingIndicator()),
      AsyncError() => ErrorPage(),
    };
  }
}
