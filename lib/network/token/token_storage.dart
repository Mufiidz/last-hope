import 'package:injectable/injectable.dart';

import '../../data/storage/in_memory_storage.dart';
import '../../data/storage/key_storage.dart';
import '../../data/storage/secure_storage.dart';
import '../../utils/string_ext.dart';

abstract class TokenStorage {
  Future<String> getAccessToken();
  Future<void> setAccessToken(String token);
  Future<void> removeAccessToken();
}

@LazySingleton(as: TokenStorage)
class TokenStorageImpl implements TokenStorage {
  final SecureStorage _secureStorage;
  final InmemoryStorage _inmemoryStorage;

  static const _key = GeneralStorageKey.accessToken;

  TokenStorageImpl(this._secureStorage, this._inmemoryStorage);

  @override
  Future<String> getAccessToken() async {
    String? token = await _inmemoryStorage.getString(_key);

    if (token.isNotBlank()) return token.orEmpty();

    token = await _secureStorage.getString(_key);

    if (token.isNotBlank()) {
      await _inmemoryStorage.setString(_key, token.orEmpty());
    }
    return token.orEmpty();
  }

  @override
  Future<void> removeAccessToken() =>
      Future.wait([_secureStorage.remove(_key), _inmemoryStorage.remove(_key)]);

  @override
  Future<void> setAccessToken(String token) {
    if (token.isEmpty) return Future.value();
    return Future.wait([
      _secureStorage.setString(_key, token),
      _inmemoryStorage.setString(_key, token),
    ]);
  }
}
