import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:free_play_app/core/router/router_manager.dart';
import 'package:free_play_app/di/service_locator.dart';
import 'package:free_play_app/screens/category/category_screen.dart';
import 'package:free_play_app/screens/explore/explore_screen.dart';
import 'package:free_play_app/screens/mine/profile_screen.dart';
import 'package:free_play_app/services/video_service.dart';
import 'package:free_play_app/widget/error_text.dart';
import 'package:free_play_app/widget/loading_indicator.dart';
import 'package:free_play_app/widget/media_grid.dart';
import 'package:signals_hooks/signals_hooks.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  static const _navItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: '主页',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.explore_outlined),
      activeIcon: Icon(Icons.explore),
      label: '发现',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category_outlined),
      activeIcon: Icon(Icons.category),
      label: '分类',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: '个人',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomIndex = useSignal<int>(0);

    final pages = useMemoized(
      () => List.generate(
        _navItems.length,
        (index) => _buildPage(index, ValueKey('page_$index')),
      ),
      const [],
    );
    return Scaffold(
      body: IndexedStack(index: bottomIndex.value, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomIndex.value,
        onTap: (index) {
          bottomIndex.value = index;
        },
        type: BottomNavigationBarType.fixed,
        items: _navItems,
      ),
    );
  }
}

Widget _buildPage(int index, ValueKey key) {
  switch (index) {
    case 0:
      return HomeContent(key: key);
    case 1:
      return ExploreScreen(key: key);
    case 2:
      return CategoryScreen(key: key);
    case 3:
      return ProfileScreen(key: key);
    default:
      return const SizedBox();
  }
}

class CarouselItems {
  final int id;
  final String url;
  const CarouselItems({required this.id, required this.url});
}

class HomeContent extends HookWidget {
  const HomeContent({super.key});
  static const _carouselItems = [
    CarouselItems(
      id: 1,
      url:
          "https://image.jinyingimage.com//cover//1f2bf1b9f0b44788ea5059094d143336.jpg",
    ),
    CarouselItems(
      id: 2,
      url:
          "https://image.jinyingimage.com//cover//fc79ab52a86965408d9a2cfd13fcef69.jpg",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardRadius = BorderRadius.circular(16);
    final vs = useMemoized(() => getIt<VideoService>());
    final popular = useFutureSignal(() => vs.fetchPopular());

    return Scaffold(
      appBar: AppBar(
        title: const Text('主页'),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: cardRadius,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: cardRadius,
                      child: FlutterCarousel(
                        options: FlutterCarouselOptions(
                          height: 220.0,
                          showIndicator: true,
                          slideIndicator: CircularSlideIndicator(),
                          autoPlay: true,
                          enableInfiniteScroll: true,
                          viewportFraction: 1.0,
                          padEnds: false,
                        ),
                        items: _carouselItems.map((carousel) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      carousel.url,
                                    ),
                                    fit: BoxFit.cover, // 关键：填充容器
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '精选推荐',
                                        style: theme.textTheme.titleLarge
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '热播第 ${carousel.id} 期',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                switch (popular.value) {
                  AsyncData(value: final videos) => Column(
                    children: [
                      MediaGrid(
                        title: '热门推荐',
                        page: RouterManager.currentPage,
                        mediaItems: videos.map((video) {
                          return MediaGridItem(
                            id: video.vodId,
                            title: video.vodName,
                            posterUrl: video.vodPic,
                            remark: video.vodRemarks,
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
                      MediaGrid(
                        title: '热门电影',
                        page: RouterManager.currentPage,
                        mediaItems: videos.map((video) {
                          return MediaGridItem(
                            id: video.vodId,
                            title: video.vodName,
                            posterUrl: video.vodPic,
                            remark: video.vodRemarks,
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
                      MediaGrid(
                        title: '热门剧集',
                        page: RouterManager.currentPage,
                        mediaItems: videos.map((video) {
                          return MediaGridItem(
                            id: video.vodId,
                            title: video.vodName,
                            posterUrl: video.vodPic,
                            remark: video.vodRemarks,
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
                  AsyncLoading() => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 48),
                    child: LoadingIndicator(),
                  ),
                  AsyncError(error: final error) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    child: ErrorText(error: error),
                  ),
                },
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
