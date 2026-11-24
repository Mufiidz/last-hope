import 'package:dart_mappable/dart_mappable.dart';

part 'story.mapper.dart';

@MappableClass()
class Story with StoryMappable {
  final String content;

  new({required this.content});
}
