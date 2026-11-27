import 'package:auto_route/auto_route.dart';
import 'package:material_ui/material_ui.dart';

import 'app_router.gr.dart';

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter() : super(navigatorKey: appNavigatorKey);

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page, path: AppRoutePath.login),
    AutoRoute(page: RegisterRoute.page, path: AppRoutePath.register),
    AutoRoute(page: HomeRoute.page, path: AppRoutePath.home),
  ];
}

abstract class AppRoutePath {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/';
}
