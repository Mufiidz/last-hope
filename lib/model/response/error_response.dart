import 'package:dart_mappable/dart_mappable.dart';

import '../../utils/default_value.dart';

part 'error_response.mapper.dart';

@MappableClass()
class ErrorResponse with ErrorResponseMappable {
  final Map<String, DataErrorResponse> data;
  final int status;
  final String message;

  const ErrorResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  ErrorResponse.empty()
    : data = emptyMap(),
      status = zeroInt(),
      message = emptyString();
}

@MappableClass()
class DataErrorResponse with DataErrorResponseMappable {
  final String code;
  final String message;

  DataErrorResponse({required this.code, required this.message});

  DataErrorResponse.empty() : this(code: emptyString(), message: emptyString());
}
