import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../utils/export_utils.dart';
import 'base_exception.dart';
import 'result.dart';

abstract class BaseUseCase<T, Param> {
  @protected
  Future<T> execute(Param param);

  Future<Result<T>> call(Param param) => safeExecute(param);

  Future<Result<T>> safeExecute(Param param) async {
    try {
      final result = await execute(param);
      return Result.success(result);
    } on DioException catch (e) {
      AppLogger.error(
        'DioException($e)',
        tag: 'Baseusecase',
        error: e,
        stackTrace: e.stackTrace,
      );
      final error = e.error;
      return switch (error) {
        SessionExpiredException() => Completer<Result<T>>().future,
        BaseException() => Result.error(error),
        _ => Result.error(
          NetworkException(e.message.orDefault('Terjadi Kesalahan')),
        ),
      };
    } on BaseException catch (e) {
      return Result.error(e);
    } catch (e) {
      AppLogger.error('ErrorBaseUsecase: $e', tag: 'Baseusecase', error: e);
      return Result.error(ErrorException('Terjadi Kesalahan'));
    }
  }
}

class NoParam {
  const NoParam();
}
