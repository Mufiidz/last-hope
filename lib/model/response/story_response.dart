import 'package:dart_mappable/dart_mappable.dart';

import '../../utils/default_value.dart';
import '../attachment.dart';
import '../base_data.dart';
import '../story.dart';

part 'story_response.mapper.dart';

@MappableClass()
class StoryResponse extends BaseData with StoryResponseMappable {
  final String collectionId;
  final String collectionName;
  final String content;
  final String creatorId;
  final StoryExpandDto? expand;
  final bool isPublish;

  StoryResponse({
    super.id = kEmptyString,
    this.collectionId = kEmptyString,
    this.collectionName = kEmptyString,
    this.content = kEmptyString,
    this.creatorId = kEmptyString,
    this.expand,
    this.isPublish = false,
    super.updated,
    super.created,
  });

  Story toStory() => Story(
    content: content,
    id: id,
    creatorId: creatorId,
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
  );
}

@MappableClass()
class StoryExpandDto with StoryExpandDtoMappable {
  @MappableField(key: 'attachments_via_story_id')
  final List<AttachmentsViaStoryId> attachmentsViaStoryId;

  StoryExpandDto({this.attachmentsViaStoryId = const []});
}

@MappableClass()
class AttachmentsViaStoryId with AttachmentsViaStoryIdMappable {
  final String id;
  final String content;
  final String description;

  AttachmentsViaStoryId({
    this.id = kEmptyString,
    this.content = kEmptyString,
    this.description = kEmptyString,
  });
}

/// Mapper StoryResponse -> Story.
/// Harus di file ini supaya bisa mengakses class private di atas.
