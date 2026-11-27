import 'package:dart_mappable/dart_mappable.dart';

import '../env.dart';
import '../utils/default_value.dart';

part 'attachment.mapper.dart';

@MappableClass()
class Attachment with AttachmentMappable {
  final String id;
  final String _content;
  final String description;

  const Attachment({
    this.id = kEmptyString,
    this._content = kEmptyString,
    this.description = kEmptyString,
  });

  String get content => '${Env.storageUrl}/attachments/$id/$_content';
}
