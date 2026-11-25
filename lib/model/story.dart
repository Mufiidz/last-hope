import 'package:dart_mappable/dart_mappable.dart';

import '../utils/default_value.dart';
import 'attachment.dart';

part 'story.mapper.dart';

@MappableClass()
class Story with StoryMappable {
  final String id;
  final String creatorId;
  final String content;
  final List<Attachment> attachments;

  new({
    required this.content,
    this.id = kEmptyString,
    this.creatorId = kEmptyString,
    this.attachments = const [],
  });
}
