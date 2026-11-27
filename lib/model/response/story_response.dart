import 'package:dart_mappable/dart_mappable.dart';

import '../../utils/default_value.dart';
import '../base_data.dart';

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
}

@MappableClass()
class StoryExpandDto with StoryExpandDtoMappable {
  @MappableField(key: 'attachments_via_storyId')
  final List<AttachmentsViaStoryId> attachmentsViaStoryId;
  @MappableField(key: 'creatorId')
  final CreatorExpandDto creator;

  StoryExpandDto({
    this.attachmentsViaStoryId = const [],
    this.creator = const CreatorExpandDto(),
  });
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

@MappableClass()
class CreatorExpandDto with CreatorExpandDtoMappable {
  final String username;
  final String name;

  const new({this.username = kEmptyString, this.name = kEmptyString});
}
