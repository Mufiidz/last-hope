import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormWidget extends StatelessWidget {
  final Key formKey;
  final AutovalidateMode? autovalidateMode;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;

  const FormWidget(
    this.formKey, {
    required this.children,
    super.key,
    this.spacing = 0,
    this.autovalidateMode,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: padding != null
          ? Padding(padding: padding ?? EdgeInsets.zero, child: _forms)
          : _forms,
    );
  }

  Column get _forms => Column(
    mainAxisAlignment: mainAxisAlignment,
    mainAxisSize: mainAxisSize,
    crossAxisAlignment: crossAxisAlignment,
    spacing: spacing,
    children: children,
  );
}
