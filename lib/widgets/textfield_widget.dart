import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:material_ui/material_ui.dart';

abstract interface class FieldKey {
  String get key;
}

class TextFieldWidget extends FormBuilderTextField {
  final FieldKey fieldKey;
  final String? label;
  final Widget? suffixIcon;
  final List<String? Function(String? value)> validators;

  TextFieldWidget(
    this.fieldKey, {
    this.validators = const [],
    this.suffixIcon,
    this.label,
    super.key,
    super.textInputAction,
    super.autovalidateMode,
    super.enabled,
    super.errorBuilder,
    super.keyboardType,
    super.maxLength,
    super.maxLines,
    super.obscureText,
    super.obscuringCharacter,
    super.initialValue,
  }) : super(
         name: fieldKey.key,
         decoration: InputDecoration(labelText: label, suffixIcon: suffixIcon),
         validator: validators.isNotEmpty
             ? FormBuilderValidators.compose(validators)
             : null,
       );
}
