import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fox_player/core/router/router_manager.dart';
import 'package:fox_player/di/service_locator.dart';
import 'package:fox_player/services/device_user_manager.dart';
import 'package:fox_player/services/video_service.dart';
import 'package:fox_player/widget/error_page.dart';
import 'package:fox_player/widget/loading_indicator.dart';
import 'package:fox_player/widget/media_card_row.dart';
import 'package:fox_player/widget/media_list.dart';
import 'package:signals_hooks/signals_hooks.dart';

class HistoryPage extends HookWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = DeviceUserManager.instance.currentUser;
    final dataNum = (user?.watchHistory?.isNotEmpty ?? false)
        ? user!.watchHistory!
        : ["-1"];
    final vs = useMemoized(() => getIt<VideoService>());
    final detailList = useFutureSignal(() => vs.fetchDetailList(dataNum));
    final double listHeight = MediaQuery.of(context).size.height * 0.80;
    return Scaffold(
      appBar: AppBar(title: const Text('观看历史'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: switch (detailList.value) {
          AsyncData(value: final videos) => MediaList(
            listHeight: listHeight,
            mediaItems: videos.map((video) {
              return MediaRow(
                id: video.vodId,
                title: video.vodName,
                posterUrl: video.vodPic,
                remark: video.vodRemarks,
                rating: video.vodDoubanScore,
                content: video.vodContent,
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
          AsyncLoading() => const Padding(
            padding: EdgeInsets.symmetric(vertical: 48),
            child: LoadingIndicator(),
          ),
          AsyncError() => Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: ErrorPage(),
          ),
        },
      ),
    );
  }
}
