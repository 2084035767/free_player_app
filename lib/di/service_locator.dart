
import 'package:free_play_app/services/auth_service.dart';
import 'package:free_play_app/services/mine_service.dart';
import 'package:free_play_app/services/video_service.dart';
import 'package:free_play_app/viewmodels/auth_view_model.dart';
import 'package:free_play_app/viewmodels/mine_view_model.dart';
import 'package:free_play_app/viewmodels/video_view_model.dart';
import 'package:get_it/get_it.dart';

import '../core/network/dio_provider.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => DioProvider().dio);
  getIt.registerLazySingleton(() => AuthService(getIt()) );
  getIt.registerFactory(() => AuthViewModel(getIt()));
  getIt.registerLazySingleton(() => MineService(getIt()));
  getIt.registerFactory(() => MineViewModel(getIt()));
  getIt.registerLazySingleton(() => VideoService(getIt()));
  getIt.registerFactory(() => VideoViewModel(getIt()));
}
