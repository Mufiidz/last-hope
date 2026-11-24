import '../model/response/story_response.dart';
import '../model/story.dart';

extension StoryMapper on StoryResponse {
  Story toStory() => Story(content: content);
}
