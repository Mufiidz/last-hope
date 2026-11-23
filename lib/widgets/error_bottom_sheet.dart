import 'package:auto_route/auto_route.dart';
import 'package:material_ui/material_ui.dart';

import '../model/error_bottomsheet_data.dart';
import '../utils/export_utils.dart';
import 'widgets_export.dart';

class ErrorBottomSheet extends StatelessWidget {
  final String? title;
  final String? message;
  final IconData? icon;
  final Color? iconColor;
  final BottomSheetAction primaryButton;
  const ErrorBottomSheet._({
    required this.primaryButton,
    this.title,
    this.message,
    this.icon,
    this.iconColor,
  });

  static void show(
    BuildContext context, {
    required ErrorBottomSheetData data,
    VoidCallback? onDismiss,
    bool isDismissible = true,
    bool useRootNavigator = false,
  }) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: useRootNavigator,
      builder: (context) => ErrorBottomSheet._(
        title: data.title ?? 'Error',
        message: data.message ?? 'Something went wrong',
        icon: data.icon ?? Icons.error_outline_rounded,
        iconColor: data.iconColor,
        primaryButton: data.primaryButton,
      ),
      transitionAnimationController: AnimationController(
        vsync: context.navigationState,
        duration: const Duration(milliseconds: 350),
        reverseDuration: const Duration(milliseconds: 300),
      ),
      isScrollControlled: true,
      isDismissible: isDismissible,
    ).then((_) {
      if (onDismiss != null) {
        onDismiss();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = iconColor ?? context.colorScheme.error;

    return Container(
      width: context.mediaSize.width,
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: context.mediaQuery.viewInsets.bottom + 32,
      ),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Space.vertical(SpaceSize.large),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: (0.1)),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 48, color: primaryColor),
          ),
          const Space.vertical(SpaceSize.medium),
          Text(
            title.orEmpty(),
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Space.vertical(SpaceSize.small),
          Text(
            message.orEmpty(),
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Button.adaptive(
            width: context.mediaSize.width,
            text: primaryButton.text,
            onPressed: primaryButton.onPressed,
          ),
        ],
      ),
    );
  }
}
