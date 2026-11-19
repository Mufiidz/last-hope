import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:material_ui/material_ui.dart';

class TextFieldWidget extends FormBuilderTextField {
  final String id;
  final String? label;
  final Widget? suffixIcon;
  final List<String? Function(String? value)> validators;

  TextFieldWidget(
    this.id, {
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
         name: id,
         decoration: InputDecoration(labelText: label, suffixIcon: suffixIcon),
         validator: validators.isNotEmpty
             ? FormBuilderValidators.compose(validators)
             : null,
       );
}
