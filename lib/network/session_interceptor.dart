import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:material_ui/material_ui.dart';

import '../model/error_bottomsheet_data.dart';
import '../routes/app_router.dart';
import '../routes/app_router.gr.dart';
import '../utils/context_ext.dart';
import 'token/token_storage.dart';

@singleton
class SessionInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;

  SessionInterceptor(this._tokenStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String accessToken = await _tokenStorage.getAccessToken();
    if (accessToken.isNotEmpty) {
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
    }
    return handler.next(err);
  }

  void _triggerSessionExpired() async {
    await _tokenStorage.removeAccessToken();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSessionBottomSheet();
    });
  }

  void _showSessionBottomSheet() {
    final context = appNavigatorKey.currentContext;
    if (context == null) return;

    void navigateToLogin() {
      context.router.pop();
      context.router.replaceAll([const LoginRoute()]);
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
      onDismiss: navigateToLogin,
    );
  }
}
