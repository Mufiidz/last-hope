import '../model/attachment.dart';
import '../model/response/story_response.dart';
import '../model/story.dart';
import '../utils/export_utils.dart';

extension StoryMapper on StoryResponse {
  Story toStory() => Story(
    content: content,
    id: id,
    creator: CreatorStory(
      id: creatorId,
      username: expand?.creator.username ?? kEmptyString,
      name: expand?.creator.name ?? kEmptyString,
    ),
    attachments:
        expand?.attachmentsViaStoryId
            .map(
              (e) => Attachment(
                id: e.id,
                content: e.content,
                description: e.description,
              ),
            )
            .toList() ??
        emptyList(),
        createdAt: created
  );
}
