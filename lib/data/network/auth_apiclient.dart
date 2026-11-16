import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/request/login_request.dart';
import '../../model/request/register_request.dart';
import '../../model/response/login_response.dart';
import '../../model/user.dart';
import 'endpoint.dart';

part 'auth_apiclient.g.dart';

@RestApi(baseUrl: Endpoint.authUrl, parser: Parser.DartMappable)
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST('/records')
  Future<User> register(@Body(nullToAbsent: true) RegisterRequest body);

  @POST('/auth-with-password')
  Future<LoginResponse> login(@Body(nullToAbsent: true) LoginRequest body);

  @POST('/auth-refresh')
  Future<LoginResponse> refreshToken();
}
