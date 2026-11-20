import 'package:dart_mappable/dart_mappable.dart';
import 'package:injectable/injectable.dart';

import '../../../base/base_export.dart';
import '../../../routes/app_router.gr.dart';
import '../../../usecase/check_auth_status_usecase.dart';
import '../../../utils/app_logger.dart';

part 'splash_screen_cubit.mapper.dart';
part 'splash_screen_state.dart';

@injectable
class SplashScreenCubit
    extends BaseCubit<SplashScreenState, SplashScreenEffect> {
  final CheckAuthStatusUseCase _checkAuthStatusUseCase;

  SplashScreenCubit(this._checkAuthStatusUseCase) : super(SplashScreenState()) {
    _init();
  }

  void _init() async {
    final result = await _checkAuthStatusUseCase(const NoParam());
    final isLoggedIn = result.when(
      success: (value) => value,
      error: (error) => false,
    );
    final route = isLoggedIn
        ? const LoginRoute().routeName
        : const LoginRoute().routeName;

    AppLogger.debug(route, tag: 'Route');

    emitEffect(SplashScreenEffect.navigate(route));
  }
}
