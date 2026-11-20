import '../../widgets/textfield_widget.dart';

enum LoginField implements FieldKey {
  identity,
  password;

  static LoginField? fromString(String value) =>
      LoginField.values.asNameMap()[value];

  @override
  String get key => name;
}
