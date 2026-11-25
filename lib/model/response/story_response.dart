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
  final _Expand? _expand;
  final bool isPublish;

  StoryResponse({
    super.id = kEmptyString,
    this.collectionId = kEmptyString,
    this.collectionName = kEmptyString,
    this.content = kEmptyString,
    this.creatorId = kEmptyString,
    this._expand,
    this.isPublish = false,
    super.updated,
    super.created,
  });
  // put attachment response here
}

@MappableClass()
class _Expand with _ExpandMappable {
  @MappableField(key: 'attachments_via_story_id')
  final List<_AttachmentsViaStoryId> attachmentsViaStoryId;

  _Expand({this.attachmentsViaStoryId = const []});
}

@MappableClass()
class _AttachmentsViaStoryId with _AttachmentsViaStoryIdMappable {
  final String id;
  final String content;
  final String description;

  _AttachmentsViaStoryId({
    this.id = kEmptyString,
    this.content = kEmptyString,
    this.description = kEmptyString,
  });
}

/// Mapper StoryResponse -> Story.
/// Harus di file ini supaya bisa mengakses class private di atas.

