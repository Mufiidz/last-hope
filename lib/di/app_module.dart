import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base/base_storage.dart';
import '../data/local/app_database.dart';
import '../data/storage/in_memory_storage.dart';
import '../data/storage/key_storage.dart';
import '../data/storage/secure_storage.dart';
import '../routes/app_router.dart';

@module
abstract class AppModule {
  @singleton
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage();

  @singleton
  AppRouter get appRouter => AppRouter();

  @preResolve
  @singleton
  Future<SharedPreferencesWithCache> get sharedPreferencesWithCache =>
      SharedPreferencesWithCache.create(
        cacheOptions: SharedPreferencesWithCacheOptions(
          allowList: SharedPrefKey.values.map((key) => key.name).toSet(),
        ),
      );

  @singleton
  AppDatabase get appDatabase => AppDatabase();

  @lazySingleton
  List<BaseStorage> getStorages(
    SecureStorage secureStorage,
    InmemoryStorage inMemoryStorage,
  ) => [inMemoryStorage, secureStorage];
}
