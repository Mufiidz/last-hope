import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../base/base_exception.dart';
import '../model/response/error_response.dart';
import '../utils/app_logger.dart';

@singleton
class NetworkInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final newException = switch (err.type) {
      DioExceptionType.connectionTimeout => NetworkException(
        'Koneksi internet terputus',
      ),
      DioExceptionType.sendTimeout => NetworkException(
        'Gagal mengirim data ke server',
      ),
      DioExceptionType.receiveTimeout => NetworkException(
        'Server terlalu lama merespons',
      ),
      DioExceptionType.connectionError => NetworkException(
        'Tidak ada koneksi internet',
      ),
      DioExceptionType.badResponse => _handleBadResponse(err),
      _ => () {
        AppLogger.error(
          err.message ?? 'Unknown error',
          'Network Interceptor',
          err.error,
          err.stackTrace,
        );
        return NetworkException(err.message ?? 'Unknown error');
      }(),
    };
    final newDioException = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: newException,
      message: newException.message,
    );
    super.onError(newDioException, handler);
  }

  BaseNetworkException _handleBadResponse(DioException err) {
    final int? statusCode = err.response?.statusCode;
    final errorData = err.response?.data;
    var errorResponse = ErrorResponse.empty();

    if (errorData is Map<String, dynamic>) {
      errorResponse = ErrorResponseMapper.fromMap(errorData);
    }

    return switch (statusCode) {
      400 => BadRequestException(errorResponse),
      403 => () {
        AppLogger.error(
          'Forbidden: ${errorResponse.message}',
          'Network Interceptor: Forbidden',
          errorData,
          err.stackTrace,
        );
        return NetworkException('Not Allowed');
      }(),
      404 => NetworkException('Not found'),
      int code when code >= 500 && code < 600 => NetworkException(
        'Terjadi kesalahan pada server',
      ),
      _ => () {
        AppLogger.error(
          'Error Bad Response ($statusCode)',
          'Network Interceptor: Bad Response',
          errorData,
          err.stackTrace,
        );
        return NetworkException('Terjadi kesalahan');
      }(),
    };
  }
}
