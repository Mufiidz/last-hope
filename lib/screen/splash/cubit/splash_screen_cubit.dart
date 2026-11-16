import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'splash_screen_cubit.mapper.dart';
part 'splash_screen_state.dart';

@injectable
class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenState()) {
    _init();
  }

  void _init() async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 2), () {
      emit(state.copyWith(isAuthenticated: false, isLoading: false));
    });
  }
}
