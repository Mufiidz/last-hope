import 'package:dart_mappable/dart_mappable.dart';

part 'story_request.mapper.dart';

@MappableClass()
class StoryRequest with StoryRequestMappable {
  final String? id;

  new({this.id});
}
