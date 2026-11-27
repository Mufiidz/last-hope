// ignore_for_file: avoid_returning_this

class ApiQueryBuilder {
  final List<String> _expands = [];
  final List<String> _fields = [];
  final List<String> _filters = [];
  final List<String> _sorts = [];

  ApiQueryBuilder expand(List<String> relations) {
    _expands.addAll(relations);
    return this;
  }

  ApiQueryBuilder select(List<String> fields) {
    _fields.addAll(fields);
    return this;
  }

  ApiQueryBuilder filterBy(String condition) {
    if (condition.trim().isNotEmpty) {
      _filters.add(condition);
    }
    return this;
  }

  ApiQueryBuilder orderByAsc(String field) {
    _sorts.add(field);
    return this;
  }

  ApiQueryBuilder orderByDesc(String field) {
    _sorts.add('-$field');
    return this;
  }

  String? get expandParam => _combine(_expands);
  String? get fieldParam => _combine(_fields);
  String? get sortParam => _combine(_sorts);
  String? get filterParam => _combine(_filters, separator: ' && ');

  String? _combine(List<String> values, {String separator = ','}) =>
      values.isNotEmpty ? values.join(separator) : null;
}
