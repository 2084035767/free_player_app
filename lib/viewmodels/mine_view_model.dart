import 'package:free_play_app/core/utils/logger.dart';
import 'package:free_play_app/models/user.dart';
import 'package:free_play_app/services/mine_service.dart';
import 'package:injectable/injectable.dart';
import 'package:signals_flutter/signals_flutter.dart';

@injectable
class MineViewModel {
  final MineService _api;

  MineViewModel(this._api);

  final profile = asyncSignal<User?>(AsyncState.data(null));

  Future<void> load() async {
    profile.value = AsyncState.loading();
    try {
      final data = await _api.fetchProfile();
      profile.value = AsyncState.data(data);
    } catch (e) {
      profile.value = AsyncState.error(e);
      Logging.error('Error loading profile: $e');
    }
  }

  void dispose() {
    profile.dispose();
  }
}
