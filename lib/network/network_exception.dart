import 'package:dio/dio.dart';

import '../base/base_exception.dart';
import '../model/response/error_response.dart';

sealed class BaseNetworkException extends BaseException {
  BaseNetworkException(super.message);
}

class BadRequestException extends BaseNetworkException {
  final ErrorResponse errorResponse;
  BadRequestException(this.errorResponse) : super(errorResponse.message);

  @override
  String toString() => 'BadRequestException: $errorResponse';
}

class NetworkException extends BaseNetworkException {
  NetworkException(super.message);

  @override
  String toString() => 'NetworkException: $message';
}

class ConnectionErrorException extends BaseNetworkException {
  final String title;
  final DioExceptionType? errorType;
  ConnectionErrorException({
    required this.title,
    required String message,
    this.errorType,
  }) : super(message);

  @override
  String toString() => 'ConnectionErrorException: $message';
}

class SessionExpiredException extends BaseNetworkException {
  SessionExpiredException(super.message);

  @override
  String toString() => 'SessionExpiredException: $message';
}

class ForbiddenException extends BaseNetworkException {
  new(super.message);
}
