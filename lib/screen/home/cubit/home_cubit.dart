import 'package:dart_mappable/dart_mappable.dart';
import 'package:injectable/injectable.dart';

import '../../../base/base_export.dart';
import '../../../model/story.dart';
import '../../../usecase/get_stories_usecase.dart';
import '../../../utils/export_utils.dart';

part 'home_state.dart';
part 'home_cubit.mapper.dart';

@injectable
class HomeCubit extends BaseCubit<HomeState, HomeEffect> {
  final GetStoriesUsecase _storiesUsecase;
  HomeCubit(this._storiesUsecase) : super(HomeState());

  void getStories([int? page]) async {
    emit(state.copyWith(statusStateScreen: StatusStateScreen.loading));

    final result = await _storiesUsecase.safeExecute(page.orZero());

    final newState = result.when(
      success: (value) => state.copyWith(
        statusStateScreen: StatusStateScreen.idle,
        stories: value,
      ),
      error: (error) => state.copyWith(
        statusStateScreen: StatusStateScreen.failure,
        message: error.message,
      ),
    );

    emit(newState);
  }
}
