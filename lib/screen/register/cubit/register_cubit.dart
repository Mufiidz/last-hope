import 'package:dart_mappable/dart_mappable.dart';
import 'package:injectable/injectable.dart';

import '../../../base/base_export.dart';
import '../../../model/error_bottomsheet_data.dart';
import '../../../model/request/register_request.dart';
import '../../../usecase/register_usecase.dart';
import '../../../utils/export_utils.dart';
import '../register_field.dart';

part 'register_state.dart';
part 'register_cubit.mapper.dart';

@injectable
class RegisterCubit extends BaseCubit<RegisterState, RegisterEffect> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit(this._registerUseCase) : super(const RegisterState()) {
    _init();
  }

  void _init() async {
    await AppOrientation.portrait();
  }

  void register(RegisterRequest param) async {
    emit(state.copyWith(statusState: StatusState.loading));

    param = param.copyWith(name: param.name ?? param.username);

    final result = await _registerUseCase.safeExecute(param);

    if (isClosed) return;

    // ERROR: when get ConnectionErrorException its navigate back to login and show bottomsheet, thats should be not like that
    final effect = result.when(
      success: (value) => RegisterEffect.navigateToLogin(),
      error: (error) {
        AppLogger.error(error.message, tag: 'RegisterCubit', error: error);
        return switch (error) {
          ForbiddenException() => RegisterEffect.showSnackBar(
            'Only admin can register an account.',
          ),
          ConnectionErrorException(:final title, :final message) =>
            RegisterEffect.showBottomSheet(
              ErrorBottomSheetData(
                title: title,
                message: message,
                primaryButton: const BottomSheetAction(text: 'Dismiss'),
              ),
            ),
          BadRequestException(:final errorResponse) => () {
            final fieldErrors = errorResponse.data.mapNotNull((key, value) {
              final fieldKey = RegisterField.fromString(key);
              final errorMessage = value.message;
              if (fieldKey == null || errorMessage.isEmpty) return null;
              return MapEntry(fieldKey, errorMessage);
            });
            return RegisterEffect.showFieldErrors(fieldErrors);
          }(),
          _ => RegisterEffect.showSnackBar(error.message),
        };
      },
    );
    emit(state.copyWith(statusState: StatusState.idle));
    emitEffect(effect);
  }

  @override
  Future<void> close() async {
    await AppOrientation.normal();
    return super.close();
  }
}
