import '../../widgets/widgets_export.dart';

enum RegisterField implements FormField {
  name,
  username,
  password,
  passwordConfirm;

  static RegisterField? fromString(String value) =>
      RegisterField.values.asNameMap()[value];

  @override
  String get key => this.name;
}
