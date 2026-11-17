import '../model/response/error_response.dart';

abstract class BaseException implements Exception {
  final String message;

  BaseException(this.message);

  @override
  String toString() => message;
}

class ErrorException extends BaseException {
  ErrorException(super.message);

  @override
  String toString() => 'Exception: $message';
}

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
