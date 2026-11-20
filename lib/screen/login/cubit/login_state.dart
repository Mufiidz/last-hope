part of 'login_cubit.dart';

@MappableClass()
class LoginState extends BaseState with LoginStateMappable {
  LoginState({super.statusState, super.message});
}

sealed class LoginEffect implements BaseEffect {
  const LoginEffect();

  factory LoginEffect.showSnackBar(String message) = ShowSnackBar;

  factory LoginEffect.navigateToHome() = NavigateToHome;

  factory LoginEffect.showFieldErrors(Map<LoginField, String> errors) =
      ShowFieldErrors;
}

class ShowFieldErrors extends LoginEffect {
  final Map<LoginField, String> errors;

  const ShowFieldErrors(this.errors);
}

class ShowSnackBar extends LoginEffect {
  final String message;

  ShowSnackBar(this.message);
}

class NavigateToHome extends LoginEffect {
  const NavigateToHome();
}
