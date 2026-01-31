import 'package:dio/dio.dart';
import 'package:free_play_app/core/utils/logger.dart';
import 'package:free_play_app/models/video.dart';

class VideoService {
  final Dio dio;
  VideoService(this.dio);

  Future<List<Video>> fetchHomeVideos() async {
    try {
      final res = await dio.get('?ac=detail&t=1&limit=6');

      return List<Video>.from(res.data['list'].map((x) => Video.fromJson(x)));
    } catch (e) {
      Logger.error('Error fetching config: $e');
      rethrow;
    }
  }

  Future<Video> fetchDetail(int id) async {
    try {
      final res = await dio.get('?ac=detail&ids=$id');
      return Video.fromJson(res.data['list'][0]);
    } catch (e) {
      Logger.error('Error fetching detail: $e');
      rethrow;
    }
  }

  Future<List<Video>> fetchCategory(int t) async {
    try {
      final res = await dio.get('?ac=detail&t=$t');
      return List<Video>.from(res.data['list'].map((x) => Video.fromJson(x)));
    } catch (e) {
      Logger.error('Error fetching detail: $e');
      rethrow;
    }
  }
  Future<List<Video>> fetchPopular() async {
    try {
      final res = await dio.get('?ac=detail&h=24');
      return List<Video>.from(res.data['list'].map((x) => Video.fromJson(x)));
    } catch (e) {
      Logger.error('Error fetching detail: $e');
      rethrow;
    }
  }

  Future<List<Video>> fetchSearch(String keyword) async {
    try {
      final encoded = Uri.encodeComponent(keyword);
      final res = await dio.get('?ac=detail&wd=$encoded');
      return List<Video>.from(res.data['list'].map((x) => Video.fromJson(x)));
    } catch (e) {
      Logger.error('Error fetching detail: $e');
      rethrow;
    }
  }

}
