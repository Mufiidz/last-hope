import 'package:injectable/injectable.dart';

import '../../base/base_storage.dart';
import 'key_storage.dart';

@singleton
class InmemoryStorage implements BaseStorage {
  final Map<String, dynamic> _inMemoryCache = {};

  @override
  Future<void> clear() async => _inMemoryCache.clear();

  @override
  Future<String?> getString(BaseStorageKey key) async => _inMemoryCache[key.name] as String?;

  @override
  Future<void> remove(BaseStorageKey key) async => _inMemoryCache.remove(key.name);

  @override
  Future<void> setString(BaseStorageKey key, String value) async => _inMemoryCache[key.name] = value;
}
