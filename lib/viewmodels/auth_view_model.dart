import 'package:free_play_app/models/user.dart';
import 'package:free_play_app/services/auth_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AuthViewModel {
  final AuthService _api;

  AuthViewModel(this._api);

  final user = asyncSignal<User?>(AsyncState.data(null));

  Future<void> login(String email, String password) async {
    user.value = AsyncState.loading();
    try {
      final data = await _api.login(email, password);
      user.value = AsyncState.data(data);
    } catch (e) {
      user.value = AsyncState.error(e);
    }
  }

  Future<void> logout() async {
    await _api.logout();
    user.value = AsyncState.data(null);
  }

  void dispose() {
    user.dispose();
  }
}
