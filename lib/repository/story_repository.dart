import 'package:injectable/injectable.dart';

import '../base/base_exception.dart';
import '../data/network/story_apiclient.dart';
import '../mapper/story_mapper.dart';
import '../model/request/story_request.dart';
import '../model/story.dart';
import '../network/api_query_builder.dart';

abstract class StoryRepository {
  Future<List<Story>> getStories({int page});
  Future<Story> postStory(StoryRequest body);
  Future<Story> updateStory(StoryRequest body);
  Future<void> deleteStory(String id);
}

@Injectable(as: StoryRepository)
class StoryRepositoryImpl implements StoryRepository {
  final StoryApiClient _apiClient;

  new(this._apiClient);

  @override
  Future<List<Story>> getStories({int page = 1}) async {
    final query = ApiQueryBuilder()
        .expand(['attachments_via_storyId', 'creatorId'])
        .select([
          '*',
          'expand.attachments_via_storyId.content',
          'expand.attachments_via_storyId.description',
          'expand.attachments_via_storyId.id',
          'expand.creatorId.name',
          'expand.creatorId.username',
        ]);
    // .filterBy('isPublish = true');
    final response = await _apiClient.getItems(
      page: page,
      expand: query.expandParam,
      field: query.fieldParam,
      filter: query.filterParam,
    );

    final stories = response.items.map((e) => e.toStory()).toList();
    return stories;
  }

  @override
  Future<void> deleteStory(String id) => _apiClient.delete(id);

  @override
  Future<Story> postStory(StoryRequest body) async {
    try {
      final response = await _apiClient.create(body);
      final story = response.toStory();
      return story;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Story> updateStory(StoryRequest body) async {
    final id = body.id;
    if (id.isEmpty) throw ErrorException('Id cant be empty');
    try {
      final response = await _apiClient.update(id, body);
      final story = response.toStory();
      return story;
    } catch (e) {
      rethrow;
    }
  }
}
