part of 'register_cubit.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.copy | GenerateMethods.stringify | GenerateMethods.equals,
)
class RegisterState extends BaseState with RegisterStateMappable {
  const RegisterState({super.statusState, super.message});
}

sealed class RegisterEffect implements BaseEffect {
  const RegisterEffect();

  factory RegisterEffect.showSnackBar(String message) = ShowSnackBar;
  factory RegisterEffect.showBottomSheet(ErrorBottomSheetData data) =
      ShowErrorBottomSheet;

  factory RegisterEffect.navigateToLogin() = NavigateToLogin;

  factory RegisterEffect.showFieldErrors(Map<RegisterField, String> errors) =
      ShowFieldErrors;
}

class ShowFieldErrors extends RegisterEffect {
  final Map<RegisterField, String> errors;

  const ShowFieldErrors(this.errors);
}

class ShowSnackBar extends RegisterEffect {
  final String message;

  ShowSnackBar(this.message);
}

class ShowErrorBottomSheet extends RegisterEffect {
  final ErrorBottomSheetData data;

  ShowErrorBottomSheet(this.data);
}

class NavigateToLogin extends RegisterEffect {
  const NavigateToLogin();
}
