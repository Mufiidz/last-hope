import 'package:dart_mappable/dart_mappable.dart';

import '../utils/default_value.dart';
import 'attachment.dart';

part 'story.mapper.dart';

@MappableClass()
class Story with StoryMappable {
  final String id;
  final String content;
  final CreatorStory creator;
  final List<Attachment> attachments;
  final DateTime? createdAt;

  new({
    required this.content,
    this.id = kEmptyString,
    this.creator = const CreatorStory(),
    this.attachments = const [],
    this.createdAt
  });
}

@MappableClass()
class CreatorStory with CreatorStoryMappable {
  final String id;
  final String username;
  final String name;

  const new({
    this.id = kEmptyString,
    this.username = kEmptyString,
    this.name = kEmptyString,
  });
}
