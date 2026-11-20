part of 'splash_screen_cubit.dart';

@MappableClass()
class SplashScreenState extends BaseState with SplashScreenStateMappable {
  SplashScreenState();
}

sealed class SplashScreenEffect implements BaseEffect {
  const SplashScreenEffect();

  factory SplashScreenEffect.navigate(String route) => NavigateScreen(route);
}

class NavigateScreen extends SplashScreenEffect {
  final String route;
  const NavigateScreen(this.route);
}
