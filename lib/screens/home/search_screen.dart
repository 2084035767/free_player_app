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

class SearchScreen extends HookWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vs = getIt<VideoService>();
    final theme = Theme.of(context);
    final controller = useMemoized(() => SearchController());
    useEffect(() => controller.dispose, [controller]);
    final query = useSignal('');
    final history = useSignal<List<String>>([]);
    final hotKeywords = useMemoized(
      () => <String>['复仇者联盟', '流浪地球', '庆余年', '周星驰', '海贼王', '三体'],
    );
    final results = useFutureSignal(
      () => vs.fetchSearch(query.value),
      dependencies: [query],
    );
    void doSearch(String text) {
      final keyword = text.trim();
      if (keyword.isEmpty) return;
      query.value = keyword;
      if (controller.text != keyword) {
        controller.text = keyword;
      }
      final nextHistory = [
        keyword,
        ...history.value.where((item) => item != keyword),
      ];
      history.value = nextHistory.take(8).toList();
      FocusScope.of(context).unfocus();
    }

    EasyRefreshController ercontroller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
    return Watch.builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  hintText: '搜索影片',
                  textInputAction: TextInputAction.search,
                  onSubmitted: doSearch,
                  trailing: [
                    if (controller.text.isNotEmpty) ...[
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          controller.clear();
                          query.value = '';
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () => doSearch(controller.text),
                      ),
                    ],
                  ],
                );
              },
              suggestionsBuilder: (context, controller) {
                final input = controller.text.trim();
                final candidates = [
                  ...history.value,
                  ...hotKeywords,
                ].where((item) => item.contains(input)).toList();
                final suggestions = input.isEmpty
                    ? history.value.take(5).toList()
                    : candidates;
                return suggestions.map((suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                    onTap: () {
                      controller.text = suggestion;
                      doSearch(suggestion);
                    },
                  );
                }).toList();
              },
            ),
          ),
          body: Watch.builder(
            builder: (context) {
              final hasQuery = query.value.isNotEmpty;
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!hasQuery) ...[
                      if (history.value.isNotEmpty) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('搜索历史', style: theme.textTheme.titleMedium),
                            TextButton(
                              onPressed: () => history.value = [],
                              child: const Text('清空'),
                            ),
                          ],
                        ),
                        Wrap(
                          spacing: 3,
                          runSpacing: 2,
                          children: history.value.map((item) {
                            return ActionChip(
                              label: Text(item),
                              onPressed: () => doSearch(item),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                      ],
                      Text('热门搜索', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 3,
                        runSpacing: 2,
                        children: hotKeywords.map((item) {
                          return ActionChip(
                            label: Text(item),
                            onPressed: () => doSearch(item),
                          );
                        }).toList(),
                      ),
                    ],
                    if (hasQuery) ...[
                      const SizedBox(height: 8),
                      switch (results.value) {
                        AsyncData(value: final videos) =>
                          videos.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 48,
                                  ),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.search_off,
                                          size: 48,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          '没有找到相关内容',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(color: Colors.grey),
                                        ),
                                        const SizedBox(height: 12),
                                      ],
                                    ),
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '搜索结果 · ${videos.length}',
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: 12),
                                    MediaPage(
                                      refresh: () {},
                                      load: () {},
                                      controller: ercontroller,
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
                                      onTap: (item) {
                                        RouterManager.pushNamed(
                                          context,
                                          RouteNames.player,
                                          pathParameters: {
                                            'id': item.id.toString(),
                                          },
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                  ],
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
                    ],
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
