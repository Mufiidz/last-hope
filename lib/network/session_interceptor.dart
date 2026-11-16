import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:material_ui/material_ui.dart';

import '../data/storage/key_storage.dart';
import '../data/storage/secure_storage.dart';
import '../model/error_bottomsheet_data.dart';
import '../routes/app_router.dart';
import '../routes/app_router.gr.dart';
import '../utils/context_ext.dart';

@singleton
class SessionInterceptor extends Interceptor {
  final SecureStorage _secureStorage;

  SessionInterceptor(this._secureStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? accessToken = await _secureStorage.getString(
      GeneralStorageKey.accessToken,
    );
    if (accessToken != null && accessToken.isNotEmpty) {
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
    await _secureStorage.remove(GeneralStorageKey.accessToken);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSessionBottomSheet();
    });
  }

  void _showSessionBottomSheet() {
    final context = appNavigatorKey.currentContext;
    if (context == null) return;

    context.showErrorBottomSheet(
      data: ErrorBottomSheetData(
        title: 'Sesi Berakhir',
        message: 'Sesi login Anda telah kedaluwarsa. Silakan masuk kembali.',
        icon: Icons.warning_amber_rounded,
        iconColor: Colors.orange,
        primaryButton: BottomSheetAction(
          text: 'Login',
          onPressed: () {
            context.router.pop();
            context.router.replaceAll([const LoginRoute()]);
          },
        ),
      ),
      onDismiss: () {
        context.router.pop();
      },
    );
  }
}
