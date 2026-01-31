import 'package:dio/dio.dart';
import 'package:free_play_app/core/utils/logger.dart';
import 'package:free_play_app/models/user.dart';

class MineService {
  final Dio dio;
  MineService(this.dio);

  Future<User> fetchProfile() async {
    try {
      final res = await dio.get('/profile');
      return User.fromJson(res.data);
    } catch (e) {
      Logger.error('Error fetching profile: $e');
      rethrow;
    }
  }
}
