// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../data/local/app_database.dart' as _i276;
import '../data/network/auth_apiclient.dart' as _i305;
import '../data/storage/in_memory_storage.dart' as _i498;
import '../data/storage/secure_storage.dart' as _i579;
import '../network/session_interceptor.dart' as _i904;
import '../routes/app_router.dart' as _i629;
import '../screen/splash/cubit/splash_screen_cubit.dart' as _i985;
import 'app_module.dart' as _i461;
import 'network_module.dart' as _i567;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    final networkModule = _$NetworkModule();
    gh.factory<_i985.SplashScreenCubit>(() => _i985.SplashScreenCubit());
    gh.singleton<_i498.InmemoryStorage>(() => _i498.InmemoryStorage());
    gh.singleton<_i558.FlutterSecureStorage>(
      () => appModule.flutterSecureStorage,
    );
    gh.singleton<_i629.AppRouter>(() => appModule.appRouter);
    await gh.singletonAsync<_i460.SharedPreferencesWithCache>(
      () => appModule.sharedPreferencesWithCache,
      preResolve: true,
    );
    gh.singleton<_i276.AppDatabase>(() => appModule.appDatabase);
    gh.singleton<_i579.SecureStorage>(
      () => _i579.SecureStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.singleton<_i904.SessionInterceptor>(
      () => _i904.SessionInterceptor(gh<_i579.SecureStorage>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.provideDio(gh<_i904.SessionInterceptor>()),
    );
    gh.singleton<_i305.AuthApiClient>(
      () => networkModule.provideAuthApiClient(gh<_i361.Dio>()),
    );
    return this;
  }
}

class _$AppModule extends _i461.AppModule {}

class _$NetworkModule extends _i567.NetworkModule {}
