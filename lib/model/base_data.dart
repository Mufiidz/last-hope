import '../utils/string_ext.dart';

abstract class BaseData {
  final String? _id;
  final DateTime? updated;
  final DateTime? created;

  new({this._id, this.updated, this.created});

  String get id => _id.orEmpty();
}
