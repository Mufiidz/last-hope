import 'package:material_ui/material_ui.dart';

class IconButtonWidget extends IconButton {
  final IconData? iconData;

  IconButtonWidget({
    required this.iconData,
    super.key,
    required super.onPressed,
  }) : super(icon: Icon(iconData));

  IconButtonWidget.filled({
    required this.iconData,
    required super.onPressed,
    super.key,
  }) : super.filled(icon: Icon(iconData));
}
