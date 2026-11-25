import 'package:dart_mappable/dart_mappable.dart';

import '../../utils/default_value.dart';
import '../base_data.dart';

part 'story_request.mapper.dart';

@MappableClass()
class StoryRequest extends BaseData with StoryRequestMappable {
  final String creatorId;
  final bool isPublish;

  new({
    this.creatorId = kEmptyString,
    this.isPublish = false,
    super.id,
    super.updated,
    super.created,
  });
}
