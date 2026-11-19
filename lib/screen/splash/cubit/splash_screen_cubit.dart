import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../base/base_usecase.dart';
import '../../../usecase/check_auth_status_usecase.dart';

part 'splash_screen_cubit.mapper.dart';
part 'splash_screen_state.dart';

@injectable
class SplashScreenCubit extends Cubit<SplashScreenState> {
  final CheckAuthStatusUseCase _checkAuthStatusUseCase;
  
  SplashScreenCubit(this._checkAuthStatusUseCase) : super(SplashScreenState()) {
    _init();
  }

  void _init() async {
    emit(state.copyWith(isLoading: true));
    final result = await _checkAuthStatusUseCase(const NoParam());
    final isLoggedIn = result.when(
      success: (value) => value,
      error: (error) => false,
    );
    emit(state.copyWith(isAuthenticated: isLoggedIn, isLoading: false));
  }
}
