// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:free_play_app/core/app_config.dart' as _i797;
import 'package:free_play_app/core/network/dio_provider.dart' as _i310;
import 'package:free_play_app/core/network/network_module.dart' as _i48;
import 'package:free_play_app/core/router/router_manager.dart' as _i923;
import 'package:free_play_app/services/auth_service.dart' as _i52;
import 'package:free_play_app/services/mine_service.dart' as _i659;
import 'package:free_play_app/services/video_service.dart' as _i112;
import 'package:free_play_app/viewmodels/auth_view_model.dart' as _i1014;
import 'package:free_play_app/viewmodels/mine_view_model.dart' as _i155;
import 'package:free_play_app/viewmodels/video_view_model.dart' as _i570;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.singleton<_i797.AppConfig>(() => _i797.AppConfig());
    gh.singleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i923.RouterManager>(() => _i923.RouterManager());
    gh.singleton<_i310.DioProvider>(() => _i310.DioProvider(gh<_i361.Dio>()));
    gh.lazySingleton<_i52.AuthService>(
      () => _i52.AuthService(gh<_i310.DioProvider>()),
    );
    gh.lazySingleton<_i659.MineService>(
      () => _i659.MineService(gh<_i310.DioProvider>()),
    );
    gh.lazySingleton<_i112.VideoService>(
      () => _i112.VideoService(gh<_i310.DioProvider>()),
    );
    gh.factory<_i1014.AuthViewModel>(
      () => _i1014.AuthViewModel(gh<_i52.AuthService>()),
    );
    gh.factory<_i155.MineViewModel>(
      () => _i155.MineViewModel(gh<_i659.MineService>()),
    );
    gh.factory<_i570.VideoViewModel>(
      () => _i570.VideoViewModel(gh<_i112.VideoService>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i48.NetworkModule {}
