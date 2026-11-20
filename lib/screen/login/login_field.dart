import '../../widgets/textfield_widget.dart';

enum LoginField implements FormField {
  identity,
  password;

  static LoginField? fromString(String value) =>
      LoginField.values.asNameMap()[value];

  @override
  String get key => name;
}
