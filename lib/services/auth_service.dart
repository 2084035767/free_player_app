import 'package:free_play_app/core/network/dio_provider.dart';
import 'package:free_play_app/models/user.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthService {
  final DioProvider dio;
  AuthService(this.dio);

  Future<User> login(String email, String pwd) async {
    final res = await dio.post(
      '/login',
      data: {'email': email, 'password': pwd},
    );
    return User.fromJson(res);
  }

  Future<void> logout() async => dio.post('/logout');
}
