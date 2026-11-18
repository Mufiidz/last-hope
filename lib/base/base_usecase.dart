import '../utils/export_utils.dart';
import 'base_exception.dart';
import 'result.dart';

abstract class BaseUsecase<T, Param> {
  Future<T> execute(Param param);

  Future<Result<T>> safeExecute(Param param) async {
    try {
      final result = await execute(param);
      return Result.success(result);
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
