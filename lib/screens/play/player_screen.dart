import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:free_play_app/core/router/router_manager.dart';
import 'package:free_play_app/core/utils/url_util.dart';
import 'package:free_play_app/di/service_locator.dart';
import 'package:free_play_app/services/video_service.dart';
import 'package:signals_hooks/signals_hooks.dart';

class PlayerPage extends HookWidget {
  final int id;

  const PlayerPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final api = getIt<VideoService>();
    final count = useSignal<int>(0);
    final detailId = useSignal<int>(id);
    final currentIndex = useSignal<int>(0);
    final playUrls = useSignal<List<String>>([]);

    final controller = useMemoized(
      () => BetterPlayerController(
        BetterPlayerConfiguration(
          aspectRatio: 16 / 9,
          fit: BoxFit.contain,
          autoPlay: true,
          translations: [
            BetterPlayerTranslations(
              languageCode: 'zh',
              generalDefaultError: '无法播放视频',
              generalNone: '无',
              generalDefault: '默认',
              generalRetry: '重试', // 修正：繁体"重試" → 简体"重试"
              playlistLoadingNextVideo: '正在加载下一个视频',
              controlsLive: '直播',
              controlsNextVideoIn: '下一个视频',
              overflowMenuPlaybackSpeed: '播放速度',
              overflowMenuSubtitles: '字幕',
              overflowMenuQuality: '画质', // 修正："质量" → 视频领域更常用"画质"
              overflowMenuAudioTracks: '音轨', // 修正：繁体"音訊" → 简体"音轨"（更符合播放器术语）
              qualityAuto: '自动', // 严重修正："汽車"（汽车）→ "自动"
            ),
          ],
          autoDispose: true,
          // placeholder: NetworkImage(currentPlayUrl.value),
        ),
      ),
    );
    final detail = useFutureSignal(
      () => api.fetchDetail(detailId.value),
      dependencies: [detailId],
    );

    final currentPlayUrl = useComputed(() {
      return currentIndex < playUrls.value.length
          ? playUrls.value[currentIndex.value]
          : '';
    });

    useEffect(() {
      detail.value.map(
        data: (video) {
          playUrls.value = UrlUtil.parseUrls(video.vodPlayUrl);
          count.value = playUrls.value.length;
          if (playUrls.isEmpty) {
            debugPrint('⚠️ 无有效播放地址');
            return;
          }
        },
        error: (e) => debugPrint('⚠️ 解析播放地址失败: $e'),
        loading: () => debugPrint('⏳ 加载播放地址中...'),
      );
      return null;
    }, [detail.value]);

    useSignalEffect(() {
      final dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        currentPlayUrl.value,
      );
      controller.setupDataSource(dataSource);
    });

    useSignalEffect(() {});
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => RouterManager.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0, // 去掉阴影
        title: detail.value.map(
          data: (video) =>
              Text('${video.vodName} - 第${currentIndex.value + 1}集'),
          error: (e) => const Text('播放中'),
          loading: () => const Text('播放中'),
        ),
      ),

      body: Watch.builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 封面区域
              AspectRatio(
                aspectRatio: 16 / 9,
                child: BetterPlayer(controller: controller),
              ),
              const Divider(height: 1),

              switch (detail.value) {
                AsyncData(value: final detail) => Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detail.vodName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${detail.vodYear} · ${detail.vodClass} · ${detail.vodDuration}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          detail.vodBlurb,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          maxLines: 4,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 12,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => controller.play(),
                                child: const Text('播放'),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Icon(Icons.favorite),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Icon(Icons.bookmark),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Icon(Icons.share),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text(
                              '本季剧集',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              '全${count.value}集',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 12,
                              ),
                          itemCount: count.value,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                currentIndex.value = index;
                              },
                              child: Center(child: Text('${index + 1}')),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AsyncLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                AsyncError(error: final error) => Text(
                  'Error: ${error.toString()}',
                ),
              },
            ],
          );
        },
      ),
    );
  }
}
