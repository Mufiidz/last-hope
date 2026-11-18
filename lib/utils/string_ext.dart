import 'default_value.dart';

extension StringExt on String? {
  String orEmpty() => this ?? emptyString();
  String orDefault([String? defaultValue]) =>
      this ?? defaultValue ?? emptyString();
  bool isNullOrEmpty() {
    final value = this;
    return value == null || value.isEmpty;
  }

  bool isNotBlank() {
    final value = this?.trim();
    return value != null && value.isNotEmpty;
  }
}
