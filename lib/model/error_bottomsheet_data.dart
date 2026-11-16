import 'package:material_ui/material_ui.dart';

class ErrorBottomSheetData {
  final String? title;
  final String? message;
  final IconData? icon;
  final Color? iconColor;
  final BottomSheetAction primaryButton;
  final BottomSheetAction? secondaryButton;

  const ErrorBottomSheetData({
    required this.primaryButton,
    this.title,
    this.message,
    this.icon,
    this.iconColor,
    this.secondaryButton,
  });
}

class BottomSheetAction {
  final String text;
  final VoidCallback? onPressed;

  const BottomSheetAction({required this.text, this.onPressed});
}
