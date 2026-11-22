import 'package:injectable/injectable.dart';

import '../base/base_usecase.dart';
import '../network/token/token_storage.dart';
import '../utils/string_ext.dart';

@lazySingleton
class CheckAuthStatusUseCase extends BaseUseCase<bool, NoParam> {
  final TokenStorage _tokenStorage;

  CheckAuthStatusUseCase(this._tokenStorage);

  @override
  Future<bool> execute(NoParam param) async {
    final result = await _tokenStorage.getAccessToken();
    return result.isNotBlank();
  }
}
