import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:free_play_app/core/router/router_manager.dart';
import 'package:free_play_app/di/service_locator.dart';
import 'package:free_play_app/services/video_service.dart';
import 'package:free_play_app/widget/error_text.dart';
import 'package:free_play_app/widget/loading_indicator.dart';
import 'package:free_play_app/widget/media_card.dart';
import 'package:free_play_app/widget/media_page.dart';
import 'package:signals_hooks/signals_hooks.dart';

enum Types {
  media('电影'),
  tv('剧集'),
  variety('综艺'),
  anime('动漫'),
  documentary('纪录片'),
  shortplay('短剧'),
  sport('体育'),
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

    final category = useFutureSignal(() => vs.fetchCategory(categoryId));
    final index = switch (categoryId) {
      11 => 0,
      3 => 1,
      27 => 2,
      25 => 3,
      16 => 4,
      30 => 5,
      29 => 6,
      31 => 7,
      _ => 0,
    };

    EasyRefreshController eRcontroller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => RouterManager.pop(context),
        ),
        title: Text(Types.values[index].title),
      ),
      body: Watch.builder(
        builder: (context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: switch (category.value) {
              AsyncData(value: final videos) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MediaPage(
                    refresh: () {},
                    load: () {},
                    controller: eRcontroller,
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
              AsyncLoading() => const Center(child: LoadingIndicator()),
              AsyncError(error: final error) => ErrorText(error: error),
            },
          );
        },
      ),
    );
  }
}
