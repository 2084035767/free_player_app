// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:fox_player/core/app_config.dart' as _i233;
import 'package:fox_player/core/network/dio_provider.dart' as _i472;
import 'package:fox_player/core/network/network_module.dart' as _i868;
import 'package:fox_player/core/router/router_manager.dart' as _i353;
import 'package:fox_player/services/auth_service.dart' as _i807;
import 'package:fox_player/services/mine_service.dart' as _i841;
import 'package:fox_player/services/video_service.dart' as _i262;
import 'package:fox_player/viewmodels/auth_view_model.dart' as _i999;
import 'package:fox_player/viewmodels/mine_view_model.dart' as _i641;
import 'package:fox_player/viewmodels/video_view_model.dart' as _i638;
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
    gh.factory<_i999.AuthViewModel>(() => _i999.AuthViewModel());
    gh.singleton<_i233.AppConfig>(() => _i233.AppConfig());
    gh.singleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i353.RouterManager>(() => _i353.RouterManager());
    gh.singleton<_i472.DioProvider>(() => _i472.DioProvider(gh<_i361.Dio>()));
    gh.lazySingleton<_i807.AuthService>(
      () => _i807.AuthService(gh<_i472.DioProvider>()),
    );
    gh.lazySingleton<_i841.MineService>(
      () => _i841.MineService(gh<_i472.DioProvider>()),
    );
    gh.lazySingleton<_i262.VideoService>(
      () => _i262.VideoService(gh<_i472.DioProvider>()),
    );
    gh.factory<_i641.MineViewModel>(
      () => _i641.MineViewModel(gh<_i841.MineService>()),
    );
    gh.factory<_i638.VideoViewModel>(
      () => _i638.VideoViewModel(gh<_i262.VideoService>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i868.NetworkModule {}
