import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../base/base_usecase.dart';
import '../model/story.dart';
import '../repository/story_repository.dart';

@lazySingleton
class GetStoriesUsecase extends BaseUseCase<List<Story>, int> {
  final StoryRepository _repository;

  new(this._repository);

  @protected
  @override
  Future<List<Story>> execute(int param) {
    if (param <= 0) {
      param = 1;
    }
    return _repository.getStories(page: param);
  }
}
