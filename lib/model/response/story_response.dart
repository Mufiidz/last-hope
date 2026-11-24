import 'package:dart_mappable/dart_mappable.dart';

import '../../utils/default_value.dart';

part 'story_response.mapper.dart';

@MappableClass()
class StoryResponse with StoryResponseMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String content;
  final DateTime? updated;
  final DateTime? created;

  StoryResponse({
    this.id = kEmptyString,
    this.collectionId = kEmptyString,
    this.collectionName = kEmptyString,
    this.content = kEmptyString,
    this.updated,
    this.created,
  });
}
