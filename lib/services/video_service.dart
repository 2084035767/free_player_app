import 'package:free_play_app/core/network/dio_provider.dart';
import 'package:free_play_app/core/utils/logger.dart';
import 'package:free_play_app/models/video.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VideoService {
  final DioProvider dio;
  VideoService(this.dio);

  Future<List<Video>> fetchHomeVideos() async {
    try {
      final res = await dio.get('?ac=detail&t=1&limit=6');

      return List<Video>.from(res['list'].map((x) => Video.fromJson(x)));
    } catch (e) {
      Logging.error('Error fetching config: $e');
      rethrow;
    }
  }

  Future<Video> fetchDetail(int id) async {
    try {
      final res = await dio.get('?ac=detail&ids=$id');
      return Video.fromJson(res['list'][0]);
    } catch (e) {
      Logging.error('Error fetching detail: $e');
      rethrow;
    }
  }

  Future<List<Video>> fetchCategory(int t) async {
    try {
      final res = await dio.get('?ac=detail&t=$t');
      return List<Video>.from(res['list'].map((x) => Video.fromJson(x)));
    } catch (e) {
      Logging.error('Error fetching detail: $e');
      rethrow;
    }
  }

  Future<List<Video>> fetchCategoryPage(int t, int page) async {
    try {
      final res = await dio.get('?ac=detail&t=$t&pg=$page');
      return List<Video>.from(res['list'].map((x) => Video.fromJson(x)));
    } catch (e) {
      Logging.error('Error fetching detail: $e');
      rethrow;
    }
  }

  Future<List<Video>> fetchPopular() async {
    try {
      final res = await dio.get('?ac=detail');
      return List<Video>.from(res['list'].map((x) => Video.fromJson(x)));
    } catch (e) {
      Logging.error('Error fetching detail: $e');
      rethrow;
    }
  }

  Future<List<Video>> fetchMovies() async {
    try {
      final res = await dio.get('?ac=detail&t=11');
      return List<Video>.from(res['list'].map((x) => Video.fromJson(x)));
    } catch (e) {
      Logging.error('Error fetching detail: $e');
      rethrow;
    }
  }

  Future<List<Video>> fetchTv() async {
    try {
      final res = await dio.get('?ac=detail&t=3');
      return List<Video>.from(res['list'].map((x) => Video.fromJson(x)));
    } catch (e) {
      Logging.error('Error fetching detail: $e');
      rethrow;
    }
  }

  Future<List<Video>> fetchShow() async {
    try {
      final res = await dio.get('?ac=detail&t=27');
      return List<Video>.from(res['list'].map((x) => Video.fromJson(x)));
    } catch (e) {
      Logging.error('Error fetching detail: $e');
      rethrow;
    }
  }

  Future<List<Video>> fetchSearch(String keyword) async {
    try {
      final encoded = Uri.encodeComponent(keyword);
      final res = await dio.get('?ac=detail&wd=$encoded');
      return List<Video>.from(res['list'].map((x) => Video.fromJson(x)));
    } catch (e) {
      Logging.error('Error fetching detail: $e');
      rethrow;
    }
  }
}
