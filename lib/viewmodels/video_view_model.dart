import 'package:free_play_app/core/utils/logger.dart';
import 'package:free_play_app/models/video.dart';
import 'package:free_play_app/services/video_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

class VideoViewModel {
  final VideoService _api;
  VideoViewModel(this._api);

  final videos = asyncSignal<List<Video>>(AsyncState.data([]));
  final detail = asyncSignal<Video?>(AsyncState.data(null));
  final searchResults = asyncSignal<List<Video>>(AsyncState.data([]));

  Future<void> loadHome() async {
    videos.value = AsyncState.loading();
    try {
      final data = await _api.fetchHomeVideos();
      videos.value = AsyncState.data(data);
    } catch (e) {
      videos.value = AsyncState.error(e);
      Logger.error('Error loading videos: $e');
    }
  }

  // 释放资源
  void dispose() {
    videos.dispose();
    detail.dispose();
    searchResults.dispose();
  }

  Future<void> loadDetail(int id) async {
    detail.value = AsyncState.loading();
    try {
      final data = await _api.fetchDetail(id);
      detail.value = AsyncState.data(data);
    } catch (e) {
      detail.value = AsyncState.error(e);
      Logger.error('Error loading detail: $e');
      rethrow;
    }
  }

  Future<void> search(String keyword) async {
    if (keyword.trim().isEmpty) {
      searchResults.value = AsyncState.data([]);
      return;
    }
    searchResults.value = AsyncState.loading();
    try {
      final data = await _api.fetchSearch(keyword);
      searchResults.value = AsyncState.data(data);
    } catch (e) {
      searchResults.value = AsyncState.error(e);
      Logger.error('Error loading search: $e');
    }
  }
}
