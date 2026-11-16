import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../../base/base_storage.dart';

import 'key_storage.dart';

@singleton
class SecureStorage implements BaseStorage {
  final FlutterSecureStorage _storage;

  SecureStorage(this._storage);

  @override
  Future<String?> getString(BaseStorageKey key) => _storage.read(key: key.name);

  @override
  Future<void> setString(BaseStorageKey key, String value) =>
      _storage.write(key: key.name, value: value);

  @override
  Future<void> remove(BaseStorageKey key) => _storage.delete(key: key.name);

  @override
  Future<void> clear() => _storage.deleteAll();
}
