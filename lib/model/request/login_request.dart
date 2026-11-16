import 'package:dart_mappable/dart_mappable.dart';

part 'login_request.mapper.dart';

@MappableClass()
class LoginRequest with LoginRequestMappable {
  final String identity;
  final String password;

  const LoginRequest({required this.identity, required this.password});
}
