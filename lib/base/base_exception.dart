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
