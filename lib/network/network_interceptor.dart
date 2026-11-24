import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../model/response/error_response.dart';
import '../utils/export_utils.dart';
import 'network_exception.dart';

@singleton
class NetworkInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final newException = switch (err.type) {
      // TODO: Maybe can be showing error bottomsheet
      DioExceptionType.connectionTimeout => () {
        AppLogger.error('connectionError', error: err);
        return ConnectionErrorException(
          title: 'Connection Timeout',
          message: 'Koneksi internet terputus',
          errorType: err.type,
        );
      }(),
      DioExceptionType.sendTimeout => NetworkException(
        'Gagal mengirim data ke server',
      ),
      DioExceptionType.receiveTimeout => NetworkException(
        'Server terlalu lama merespons',
      ),
      DioExceptionType.connectionError => () {
        // TODO: Handle this when get connection error or when cant connect to server
        AppLogger.error('connectionError', error: err);
        return ConnectionErrorException(
          title: 'Connection Error',
          message: 'Tidak ada koneksi internet',
          errorType: err.type,
        );
      }(),
      DioExceptionType.badResponse => _handleBadResponse(err),

      _ => () {
        AppLogger.error(
          err.message ?? 'Unknown error',
          tag: 'Network Interceptor',
          error: err.error,
          stackTrace: err.stackTrace,
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
      400 => () {
        if (errorResponse.data.isNotEmpty) {
          return BadRequestException(errorResponse);
        }
        return NetworkException(errorResponse.message);
      }(),
      403 => () {
        AppLogger.error(
          'Forbidden: ${errorResponse.message}',
          tag: 'Network Interceptor: Forbidden',
          error: errorData,
          stackTrace: err.stackTrace,
        );
        return ForbiddenException('Not Allowed');
      }(),
      404 => NetworkException('Not found'),
      int code when code >= 500 && code < 600 => NetworkException(
        'Terjadi kesalahan pada server',
      ),
      _ => () {
        AppLogger.error(
          'Error Bad Response ($statusCode)',
          tag: 'Network Interceptor: Bad Response',
          error: errorData,
          stackTrace: err.stackTrace,
        );
        return NetworkException('Terjadi kesalahan');
      }(),
    };
  }
}
