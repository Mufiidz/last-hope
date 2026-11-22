import 'package:flutter/widget_previews.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:material_ui/material_ui.dart';

import '../screen/login/login_field.dart';
import '../utils/context_ext.dart';

abstract interface class FormField {
  String get key;
}

class TextFieldWidget extends FormBuilderTextField {
  final FormField formField;
  final String? label;
  final Widget? suffixIcon;
  final List<String? Function(String? value)> validators;
  final bool filled;
  final String? hint;
  final EdgeInsetsGeometry contentPadding;
  final double? borderRadius;

  TextFieldWidget(
    this.formField, {
    this.borderRadius,
    this.hint,
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
    this.filled = false,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 16,
      horizontal: 8,
    ),
    super.forceErrorText,
    super.onSubmitted,
  }) : super(
         name: formField.key,
         decoration: InputDecoration(
           labelText: label,
           suffixIcon: suffixIcon,
           filled: filled,
           border: OutlineInputBorder(
             borderSide: BorderSide.none,
             borderRadius: BorderRadius.circular(borderRadius ?? 12),
           ),
           hintText: hint,
           contentPadding: contentPadding,
         ),
         validator: validators.isNotEmpty
             ? FormBuilderValidators.compose(validators)
             : null,
       );

  TextFieldWidget.border(
    this.formField,
    BuildContext context, {
    this.borderRadius,
    this.hint,
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
    this.filled = false,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 16,
      horizontal: 8,
    ),
    InputBorder? enabledBorder,
    super.forceErrorText,
    super.onSubmitted,
  }) : super(
         name: formField.key,
         decoration: InputDecoration(
           labelText: label,
           suffixIcon: suffixIcon,
           filled: filled,
           hintText: hint,
           border: OutlineInputBorder(
             borderSide: BorderSide(
               width: 2,
               color: context.colorScheme.primary,
             ),
             borderRadius: BorderRadius.all(
               Radius.circular(borderRadius ?? 12),
             ),
           ),
           enabledBorder: OutlineInputBorder(
             borderSide: BorderSide(width: 2, color: Colors.grey.shade200),
             borderRadius: BorderRadius.all(
               Radius.circular(borderRadius ?? 12),
             ),
           ),
           focusedBorder: OutlineInputBorder(
             borderSide: BorderSide(
               width: 2,
               color: context.colorScheme.primary,
             ),
             borderRadius: BorderRadius.all(
               Radius.circular(borderRadius ?? 12),
             ),
           ),
           errorBorder: OutlineInputBorder(
             borderSide: BorderSide(width: 2, color: context.colorScheme.error),
             borderRadius: BorderRadius.all(
               Radius.circular(borderRadius ?? 12),
             ),
           ),
           focusedErrorBorder: OutlineInputBorder(
             borderSide: BorderSide(width: 2, color: context.colorScheme.error),
             borderRadius: BorderRadius.all(
               Radius.circular(borderRadius ?? 12),
             ),
           ),
           contentPadding: contentPadding,
         ),
         validator: validators.isNotEmpty
             ? FormBuilderValidators.compose(validators)
             : null,
       );

  TextFieldWidget.focusBorder(
    this.formField,
    BuildContext context, {
    this.borderRadius,
    this.hint,
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
    this.filled = false,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 16,
      horizontal: 8,
    ),
    InputBorder? enabledBorder,
    super.forceErrorText,
    super.onSubmitted,
  }) : super(
         name: formField.key,
         decoration: InputDecoration(
           labelText: label,
           suffixIcon: suffixIcon,
           filled: filled,
           hintText: hint,
           border: OutlineInputBorder(
             borderSide: BorderSide.none,
             borderRadius: BorderRadius.all(
               Radius.circular(borderRadius ?? 12),
             ),
           ),
           focusedBorder: OutlineInputBorder(
             borderSide: BorderSide(
               width: 2,
               color: context.colorScheme.primary,
             ),
             borderRadius: BorderRadius.all(
               Radius.circular(borderRadius ?? 12),
             ),
           ),
           errorBorder: OutlineInputBorder(
             borderSide: BorderSide(width: 2, color: context.colorScheme.error),
             borderRadius: BorderRadius.all(
               Radius.circular(borderRadius ?? 12),
             ),
           ),
           focusedErrorBorder: OutlineInputBorder(
             borderSide: BorderSide(width: 2, color: context.colorScheme.error),
             borderRadius: BorderRadius.all(
               Radius.circular(borderRadius ?? 12),
             ),
           ),
           contentPadding: contentPadding,
         ),
         validator: validators.isNotEmpty
             ? FormBuilderValidators.compose(validators)
             : null,
       );
}

@Preview(name: 'TextFieldWidget')
Widget previewTextFieldWidget() {
  return Builder(
    builder: (context) {
      return MaterialApp(
        theme: context.materialTheme.light(),
        home: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          width: 300,
          child: FormBuilder(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                TextFieldWidget(
                  LoginField.identity,
                  label: 'Default',
                  hint: 'Input teks',
                ),
                TextFieldWidget(
                  LoginField.identity,
                  label: 'Filled Rounded',
                  hint: 'Input teks',
                  filled: true,
                ),
                TextFieldWidget(
                  LoginField.identity,
                  label: 'Filled Rounded',
                  hint: 'Input teks',
                  filled: true,
                  enabled: false,
                ),
                TextFieldWidget.border(
                  LoginField.identity,
                  context,
                  label: 'Border',
                  hint: 'Input teks',
                  suffixIcon: const Icon(Icons.search),
                ),
                TextFieldWidget.border(
                  LoginField.identity,
                  context,
                  label: 'Border',
                  hint: 'Input teks',
                  filled: true,
                  suffixIcon: const Icon(Icons.search),
                ),
                TextFieldWidget.border(
                  LoginField.identity,
                  context,
                  label: 'Border',
                  hint: 'Input teks',
                  suffixIcon: const Icon(Icons.search),
                  enabled: false,
                ),
                TextFieldWidget.focusBorder(
                  LoginField.identity,
                  context,
                  label: 'Focus Border',
                  hint: 'Input teks',
                  filled: true,
                  suffixIcon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
