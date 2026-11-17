import 'package:dart_mappable/dart_mappable.dart';

part 'result.mapper.dart';

sealed class Result<T> {
  const Result();

  /// Creates a successful [Result], completed with the specified [value].
  const factory Result.success(T value) = Success._;

  /// Creates an error [Result], completed with the specified [error].
  const factory Result.error(Exception error) = Error._;
}

/// A successful [Result] with a returned [value].
@MappableClass(
  generateMethods: GenerateMethods.equals | GenerateMethods.stringify,
)
class Success<T> extends Result<T> with SuccessMappable {
  const Success._(this.value);

  /// The returned value of this result.
  final T value;
}

/// An error [Result] with a resulting [error].
@MappableClass(
  generateMethods: GenerateMethods.equals | GenerateMethods.stringify,
)
class Error<T> extends Result<T> with ErrorMappable {
  const Error._(this.error);

  /// The resulting error of this result.
  final Exception error;
}
