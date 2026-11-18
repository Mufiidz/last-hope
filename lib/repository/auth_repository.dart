import 'package:injectable/injectable.dart';

import '../data/network/auth_apiclient.dart';
import '../data/storage/in_memory_storage.dart';
import '../data/storage/key_storage.dart';
import '../data/storage/secure_storage.dart';
import '../model/request/login_request.dart';
import '../model/request/register_request.dart';
import '../model/user.dart';
import '../utils/export_utils.dart';

abstract class AuthRepository {
  Future<User> login(LoginRequest request);
  Future<User> register(RegisterRequest request);
  Future<void> refreshToken();
  Future<String?> getAccessToken();
}

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthApiClient _apiClient;
  final SecureStorage _secureStorage;
  final InmemoryStorage _inmemoryStorage;

  AuthRepositoryImpl(
    this._apiClient,
    this._secureStorage,
    this._inmemoryStorage,
  );

  @override
  Future<User> login(LoginRequest request) async {
    try {
      final response = await _apiClient.login(request);
      await _secureStorage.setString(
        GeneralStorageKey.accessToken,
        response.token,
      );
      return response.user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> register(RegisterRequest request) =>
      _apiClient.register(request);

  @override
  Future<void> refreshToken() async {
    try {
      final response = await _apiClient.refreshToken();
      return await _secureStorage.setString(
        GeneralStorageKey.accessToken,
        response.token,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> getAccessToken() async {
    String? token = await _inmemoryStorage.getString(
      GeneralStorageKey.accessToken,
    );

    AppLogger.debug(token, tag: 'getAccessToken');

    if (token.isNotBlank()) return token;

    token = await _secureStorage.getString(GeneralStorageKey.accessToken);
    // TODO: Handle to save token to inmemory
    return token;
  }
}
