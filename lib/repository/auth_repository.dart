import 'package:injectable/injectable.dart';

import '../data/network/auth_apiclient.dart';
import '../model/request/login_request.dart';
import '../model/request/register_request.dart';
import '../model/user.dart';
import '../network/token/token_storage.dart';

abstract class AuthRepository {
  Future<User> login(LoginRequest request);
  Future<User> register(RegisterRequest request);
  Future<void> refreshToken();
}

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthApiClient _apiClient;
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl(this._apiClient, this._tokenStorage);

  @override
  Future<User> login(LoginRequest request) async {
    try {
      final response = await _apiClient.login(request);
      await _tokenStorage.setAccessToken(response.token);
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
      return await _tokenStorage.setAccessToken(response.token);
    } catch (e) {
      rethrow;
    }
  }
}
