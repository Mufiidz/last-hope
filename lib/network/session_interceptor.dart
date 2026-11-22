import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:material_ui/material_ui.dart';

import '../base/base_exception.dart';
import '../data/network/endpoint.dart';
import '../di/injection.dart';
import '../model/error_bottomsheet_data.dart';
import '../routes/app_router.dart';
import '../routes/app_router.gr.dart';
import '../utils/export_utils.dart';
import 'token/token_storage.dart';

@singleton
class SessionInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;

  SessionInterceptor(this._tokenStorage);

  final Set<String> _whitelisted = Set.of({
    '${Endpoint.authUrl}/records',
    '${Endpoint.authUrl}/auth-with-password',
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final currentPath = '${options.baseUrl}${options.path}';
    AppLogger.debug(currentPath);
    final String accessToken = await _tokenStorage.getAccessToken();
    if (accessToken.isNotEmpty && !_whitelisted.contains(currentPath)) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final errorResponse = err.response;
    if (errorResponse?.statusCode == 401) {
      // TODO: Handle to refresh token
      _triggerSessionExpired();
      return handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: SessionExpiredException('Sesi Berakhir'),
          message: 'Sesi berakhir',
        ),
      );
    }
    return handler.next(err);
  }

  void _triggerSessionExpired() async {
    await _tokenStorage.removeAccessToken();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSessionBottomSheet();
    });
  }

  bool _isSessionSheetShowing = false;

  void _showSessionBottomSheet() {
    if (_isSessionSheetShowing) return;

    final navigator = appNavigatorKey.currentState;

    final context = navigator?.overlay?.context;
    if (navigator == null || context == null) return;

    _isSessionSheetShowing = true;

    // handle navigate to login
    var handled = false;

    void navigateToLogin() {
      if (handled) return;
      final appRouter = getIt<AppRouter>();
      handled = true;
      _isSessionSheetShowing = false;

      navigator.popUntil((route) => route is! PopupRoute);

      if (appRouter.topRoute.name != LoginRoute.name) {
        appRouter.replaceAll([const LoginRoute()]);
      }
    }

    context.showErrorBottomSheet(
      data: ErrorBottomSheetData(
        title: 'Sesi Berakhir',
        message: 'Sesi login Anda telah kedaluwarsa. Silakan masuk kembali.',
        icon: Icons.warning_amber_rounded,
        iconColor: Colors.orange,
        primaryButton: BottomSheetAction(
          text: 'Login',
          onPressed: navigateToLogin,
        ),
      ),
      useRootNavigator: true,
      onDismiss: navigateToLogin,
    );
  }
}
