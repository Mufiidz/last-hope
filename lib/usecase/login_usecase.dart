import 'package:injectable/injectable.dart';

import '../base/base_usecase.dart';
import '../model/request/login_request.dart';
import '../model/user.dart';
import '../repository/auth_repository.dart';

@singleton
class LoginUseCase extends BaseUseCase<User, LoginRequest> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<User> execute(LoginRequest param) {
    final request = param.copyWith(
      identity: param.identity.trim().toLowerCase(),
    );
    return _authRepository.login(request);
  }
}
