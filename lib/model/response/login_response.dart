import 'package:dart_mappable/dart_mappable.dart';

import '../user.dart';

part 'login_response.mapper.dart';

@MappableClass()
class LoginResponse with LoginResponseMappable {
  @MappableField(key: 'record')
  final User user;
  final String token;

  const LoginResponse({required this.token, this.user = const User.empty()});
}
