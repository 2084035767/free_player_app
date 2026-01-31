import 'package:dio/dio.dart';
import 'package:free_play_app/models/user.dart';

class AuthService {
  final Dio dio;
  AuthService(this.dio);

  Future<User> login(String email, String pwd) async {
    final res = await dio.post(
      '/login',
      data: {'email': email, 'password': pwd},
    );
    return User.fromJson(res.data);
  }

  Future<void> logout() async => dio.post('/logout');
}
