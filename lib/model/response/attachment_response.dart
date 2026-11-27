import 'package:dart_mappable/dart_mappable.dart';

import '../base_data.dart';

part 'attachment_response.mapper.dart';

@MappableClass()
class AttachmentResponse extends BaseData with AttachmentResponseMappable {
  final String collectionId;
  final String collectionName;
  final String content;
  final String description;
  final String storyId;

  AttachmentResponse({
    required this.collectionId,
    required this.collectionName,
    required this.content,
    required this.description,
    required this.storyId,
    super.id,
    super.created,
    super.updated,
  });
}
