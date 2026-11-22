import 'package:material_ui/material_ui.dart';

import '../utils/export_utils.dart';

enum SnackBarState { normal, success, error }

class SnackBarWidget extends SnackBar {
  final String message;
  SnackBarWidget({
    required this.message,
    super.key,
    super.action,
    super.dismissDirection,
    super.duration,
    super.backgroundColor,
  }) : super(content: Text(message), behavior: SnackBarBehavior.floating);

  SnackBarWidget.byState(
    BuildContext context, {
    required this.message,
    SnackBarState state = SnackBarState.normal,
    super.key,
    super.action,
    super.dismissDirection,
    super.duration,
  }) : super(
         content: Text(message),
         behavior: SnackBarBehavior.floating,
         backgroundColor: _getBackgroundColor(context, state),
       );

  static Color? _getBackgroundColor(
    BuildContext context,
    SnackBarState state,
  ) => switch (state) {
    SnackBarState.success =>
      context.isDark ? Colors.green[300] : Colors.green[700],
    SnackBarState.error => context.colorScheme.error,
    _ => null,
  };
}
