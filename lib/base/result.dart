import 'base_exception.dart';

sealed class Result<T> {
  const Result();

  const factory Result.success(T value) = _Success._;

  const factory Result.error(BaseException error) = _Error._;

  R when<R>({
    required R Function(T value) success,
    required R Function(BaseException error) error,
  }) {
    return switch (this) {
      _Success(value: final v) => success(v),
      _Error(error: final e) => error(e),
    };
  }
}

class _Success<T> extends Result<T> {
  final T value;

  const _Success._(this.value);

  @override
  String toString() => 'Result.Success($value)';
}

class _Error<T> extends Result<T> {
  final BaseException error;

  const _Error._(this.error);

  @override
  String toString() => 'Result.Error($error)';
}
