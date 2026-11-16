import 'package:dart_mappable/dart_mappable.dart';

part 'user.mapper.dart';

@MappableClass()
class User with UserMappable {
  final String username;
  final String id;
  final DateTime? created;
  final String? name;

  const User({required this.id, this.created, this.name, this.username = ''});

  const User.empty() : username = '', id = '', created = null, name = null;
}
