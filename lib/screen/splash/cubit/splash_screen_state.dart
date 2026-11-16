part of 'splash_screen_cubit.dart';

@MappableClass()
class SplashScreenState with SplashScreenStateMappable {
  final bool isLoading;
  final bool? isAuthenticated;

  new({this.isLoading = true, this.isAuthenticated});
}
