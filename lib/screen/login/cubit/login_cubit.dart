import 'package:dart_mappable/dart_mappable.dart';
import 'package:injectable/injectable.dart';

import '../../../base/base_export.dart';
import '../../../model/request/login_request.dart';
import '../../../usecase/login_usecase.dart';
import '../../../utils/export_utils.dart';
import '../login_field.dart';

part 'login_state.dart';
part 'login_cubit.mapper.dart';

@injectable
class LoginCubit extends BaseCubit<LoginState, LoginEffect> {
  final LoginUseCase _loginUseCase;
  LoginCubit(this._loginUseCase) : super(LoginState());

  void login(LoginRequest param) async {
    emit(state.copyWith(statusState: StatusState.loading));

    final result = await _loginUseCase.safeExecute(param);

    if (isClosed) return;

    final effect = result.when(
      success: (value) => LoginEffect.navigateToHome(),
      error: (error) {
        if (error is BadRequestException) {
          final fieldErrors = error.errorResponse.data.mapNotNull((key, value) {
            final fieldKey = LoginField.fromString(key);
            final errorMessage = value.message;
            if (fieldKey == null || errorMessage.isEmpty) return null;
            return MapEntry(fieldKey, errorMessage);
          });
          return LoginEffect.showFieldErrors(fieldErrors);
        } else {
          return LoginEffect.showSnackBar(error.message);
        }
      },
    );
    emit(state.copyWith(statusState: StatusState.idle));
    emitEffect(effect);
  }
}
