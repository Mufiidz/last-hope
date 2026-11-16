import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';

import '../utils/context_ext.dart';

enum _ButtonType { icon, adaptive }

class Button extends StatelessWidget {
  final String text;
  final TextStyle? titleStyle;
  final _ButtonType? _type;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isDisabled;
  final double? width;
  final double? height;

  const Button({
    super.key,
    required this.text,
    this.titleStyle,
    this.onPressed,
    this.isDisabled = false,
    this.width,
    this.height = 50,
  }) : _type = null,
       icon = null;

  const Button.adaptive({
    super.key,
    required this.text,
    this.titleStyle,
    this.onPressed,
    this.isDisabled = false,
    this.width,
    this.height = 50,
  }) : _type = _ButtonType.adaptive,
       icon = null;

  const Button.icon({
    super.key,
    required this.text,
    required this.icon,
    this.titleStyle,
    this.onPressed,
    this.isDisabled = false,
    this.width,
    this.height = 50,
  }) : _type = _ButtonType.icon;

  @override
  Widget build(BuildContext context) {
    var newTitleStyle = context.textTheme.bodyLarge?.copyWith(
      color: context.colorScheme.surface,
      fontWeight: FontWeight.bold,
    );
    newTitleStyle = newTitleStyle?.merge(titleStyle);

    final buttonWidget = switch (_type) {
      _ButtonType.icon when icon != null => FilledButton.icon(
        icon: Icon(icon),
        label: Text(text, style: newTitleStyle),
        onPressed: isDisabled ? null : onPressed,
      ),
      _ButtonType.adaptive when context.platform == TargetPlatform.iOS =>
        CupertinoButton.filled(
          onPressed: isDisabled ? null : onPressed,
          child: Text(text, style: newTitleStyle),
        ),
      _ => FilledButton(
        onPressed: isDisabled ? null : onPressed,
        child: Text(text, style: newTitleStyle),
      ),
    };

    if (width == null && height == null) return buttonWidget;

    return SizedBox(width: width, height: height, child: buttonWidget);
  }
}
