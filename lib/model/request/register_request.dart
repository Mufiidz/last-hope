import 'package:dart_mappable/dart_mappable.dart';

part 'register_request.mapper.dart';

@MappableClass()
class RegisterRequest with RegisterRequestMappable {
  final String username;
  final String password;
  @MappableField(key: 'passwordConfirm')
  final String confirmPassword;
  final String? name;
  final String? email;

  const RegisterRequest({
    required this.username,
    required this.password,
    required this.confirmPassword,
    this.name,
    this.email,
  });
}
