import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fox_player/core/router/router_manager.dart';
import 'package:fox_player/core/utils/str_util.dart';
import 'package:fox_player/di/service_locator.dart';
import 'package:fox_player/services/device_user_manager.dart';
import 'package:fox_player/services/video_service.dart';
import 'package:fox_player/widget/error_text.dart';
import 'package:fox_player/widget/expandable_text.dart';
import 'package:fox_player/widget/loading_indicator.dart';
import 'package:line_icons/line_icons.dart';
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
    final isFavorite = useSignal<bool>(false); // 收藏状态信号
    final isBookmarked = useSignal<bool>(false); // 书签状态信号
    final isShared = useSignal<bool>(false); // 分享状态信号（虽然分享通常不需要切换状态，但按需求实现）
    final user = DeviceUserManager.instance.currentUser;
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
          controlsConfiguration: BetterPlayerControlsConfiguration(
            playIcon: LineIcons.play,
            pauseIcon: LineIcons.pause,
            muteIcon: LineIcons.volumeUp,
            unMuteIcon: LineIcons.volumeOff,
            fullscreenEnableIcon: LineIcons.expand,
            fullscreenDisableIcon: LineIcons.compress,
          ),
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
          playUrls.value = StrUtil.parseUrls(video.vodPlayUrl);
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
    useEffect(() {
      return () {
        controller.dispose();
      };
    }, [controller]);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => RouterManager.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                          '${detail.vodYear} | ${detail.vodArea} | ${detail.vodClass}',
                          style: theme.textTheme.bodyLarge?.copyWith(),
                        ),
                        const SizedBox(height: 6),
                        ExpandableText(
                          text: StrUtil.cleanDescription(detail.vodContent),
                          style: theme.textTheme.bodyLarge?.copyWith(),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 12,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => controller.play(),
                                child: Icon(LineIcons.play),
                              ),
                            ),

                            ElevatedButton(
                              onPressed: () {
                                isBookmarked.value =
                                    !isBookmarked.value;
                                if (user != null) {
                                  DeviceUserManager.instance.updateUser(user.copyWith(
                                    favorites: isBookmarked.value
                                        ? [...?user.favorites, detailId.value.toString()]
                                        : user.favorites
                                            ?.where((id) => id != detailId.value.toString())
                                            .toList(),
                                  ));
                                }
                              },
                              child: Icon(
                                isBookmarked.value
                                    ? Icons
                                          .bookmark // 实心图标（已书签）
                                    : Icons.bookmark_border, // 空心图标（未书签）
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                isFavorite.value = !isFavorite.value; // 切换收藏状态
                                if (user != null) {
                                  DeviceUserManager.instance.updateUser(user.copyWith(
                                    watchLater: isFavorite.value
                                        ? [...?user.watchLater, detailId.value.toString()]
                                        : user.watchLater
                                            ?.where((id) => id != detailId.value.toString())
                                            .toList(),
                                  ));
                                }
                              },
                              child: Icon(
                                isFavorite.value
                                    ? Icons.watch_later // 实心图标（已添加到稍后观看）
                                    : Icons.watch_later_outlined, // 空心图标（未添加到稍后观看）
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                isShared.value = !isShared.value; // 切换分享状态
                                // 分享通常不需要持久化到用户数据中，但如果需要可以添加逻辑
                                // 目前保持原样，只切换本地状态
                              },
                              child: Icon(
                                isShared.value
                                    ? Icons
                                          .share // 实心图标（已分享）
                                    : Icons.share_outlined, // 空心图标（未分享）
                              ),
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
                              '${count.value}集',
                              style: theme.textTheme.bodyMedium?.copyWith(),
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
                            child:
                                ElevatedButton(
                                      onPressed: () {
                                        currentIndex.value = index;
                                      },
                                      child: Center(
                                        child: Text('${index + 1}'),
                                      ),
                                    )
                                    .animate()
                                    .fadeIn(duration: 300.ms)
                                    .slideY(begin: 0.2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AsyncLoading() => const Center(child: LoadingIndicator()),
                AsyncError(error: final error) => ErrorText(error: error),
              },
            ],
          );
        },
      ),
    );
  }
}
