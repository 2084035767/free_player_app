import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:free_play_app/core/router/router_manager.dart';
import 'package:free_play_app/di/service_locator.dart';
import 'package:free_play_app/services/video_service.dart';
import 'package:free_play_app/widget/media_page.dart';
import 'package:signals_hooks/signals_hooks.dart';

enum Types {
  media('电影'),
  tv('剧集'),
  variety('综艺'),
  anime('动漫'),
  documentary('纪录片'),
  shortplay('短片'),
  sport('运动'),
  more('更多');

  final String title;
  const Types(this.title);
}

class CustomScreen extends HookWidget {
  final int categoryId;
  const CustomScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final vs = useMemoized(() => getIt<VideoService>());
    final categoryIndex = useSignal<int>(categoryId);

    final category = useFutureSignal(
      () => vs.fetchCategory(categoryIndex.value),
      dependencies: [categoryIndex],
    );

    return Watch.builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => RouterManager.pop(context),
            ),
            title: Text(Types.values[categoryIndex.value].title),
          ),
          body: Watch.builder(
            builder: (context) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: switch (category.value) {
                  AsyncData(value: final videos) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MediaPage(
                        mediaItems: videos.map((video) {
                          return MediaPageItem(
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
      },
    );
  }
}
