import 'package:injectable/injectable.dart';

import '../base/base_usecase.dart';
import '../model/request/register_request.dart';
import '../model/user.dart';
import '../repository/auth_repository.dart';

@singleton
class RegisterUseCase extends BaseUseCase<User, RegisterRequest> {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);
  @override
  Future<User> execute(RegisterRequest param) {
    final request = param.copyWith(
      username: param.username.trim().toLowerCase(),
    );
    return _authRepository.register(request);
  }
}
