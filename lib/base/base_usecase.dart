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
      final error = e.error;
      if (error is BaseException) {
        return Result.error(error);
      }
      return Result.error(
        NetworkException(e.message.orDefault('Terjadi Kesalahan')),
      );
    } on BaseException catch (e) {
      return Result.error(e);
    } catch (e) {
      AppLogger.error('ErrorBaseUsecase: $e', 'Baseusecase', e);
      return Result.error(ErrorException('Terjadi Kesalahan'));
    }
  }
}

class NoParam {
  const NoParam();
}
