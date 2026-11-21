import 'dart:io';
import 'dart:ui';

import 'package:material_ui/material_ui.dart';

import '../utils/export_utils.dart';
import '../utils/unit_sizing_ext.dart';
import 'widgets_export.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final double blurSigma;
  final bool showBackButton;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onBackPressed;
  final EdgeInsetsGeometry? actionsPadding;
  final bool centerTitle;

  const AppBarWidget({
    this.trailing,
    this.actionsPadding,
    this.onBackPressed,
    this.actions,
    this.leading,
    super.key,
    this.title = kEmptyString,
    this.height = kToolbarHeight,
    this.blurSigma = 2,
    this.showBackButton = false,
    this.centerTitle = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  static const double _sideSlotWidth = 48;
  static const double _gap = 8;

  @override
  Widget build(BuildContext context) {
    final topPadding = context.mediaQuery.padding.top;
    final totalHeight = preferredSize.height + topPadding;
    final backgroundColor = context.colorScheme.surface;

    return SizedBox(
      height: totalHeight,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.4, 1],
                      colors: [
                        backgroundColor.withValues(alpha: 0.6),
                        backgroundColor.withValues(alpha: 0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: topPadding + 4,
              left: 16,
              right: 16,
              bottom: 6,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: _sideSlotWidth + _gap,
                      right: _sideSlotWidth + _gap,
                    ),
                    child: _titleAppBar(context),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _leadingAppBar(context),
                ),
                if (trailing != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: _trailingAppBar(context),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _leadingAppBar(BuildContext context) {
    if (showBackButton) {
      return IconButtonWidget.filled(
        iconData: Platform.isIOS ? Icons.arrow_back_ios_new : Icons.arrow_back,
        onPressed: onBackPressed,
      );
    }

    final leading = this.leading;
    if (leading != null) {
      return leading;
    } else {
      return const EmptyWidget();
    }
  }

  Widget _titleAppBar(BuildContext context) {
    if (title.isEmpty) return const EmptyWidget();
    return Align(
      alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: context.textTheme.displaySmall?.fontSize?.sp(context),
        ),
      ),
    );
  }

  Widget _trailingAppBar(BuildContext context) {
    final trailing = this.trailing;
    if (trailing != null) {
      return trailing;
    } else {
      return const EmptyWidget();
    }
  }
}
