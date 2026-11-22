import 'package:dart_mappable/dart_mappable.dart';
import 'package:material_ui/material_ui.dart';

part 'error_bottomsheet_data.mapper.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.copy | GenerateMethods.stringify | GenerateMethods.equals,
)
class ErrorBottomSheetData with ErrorBottomSheetDataMappable {
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

@MappableClass(
  generateMethods:
      GenerateMethods.copy | GenerateMethods.stringify | GenerateMethods.equals,
)
class BottomSheetAction with BottomSheetActionMappable {
  final String text;
  final VoidCallback? onPressed;

  const BottomSheetAction({required this.text, this.onPressed});
}
