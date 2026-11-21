import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

import '../model/error_bottomsheet_data.dart';
import '../theme.dart';
import '../widgets/error_bottom_sheet.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  MaterialTheme get materialTheme => MaterialTheme(this);
  TextTheme createTextTheme({
    String displayFontString = 'Figtree',
    String bodyFontString = 'Roboto',
  }) {
    TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
      bodyFontString,
      textTheme,
    );
    TextTheme displayTextTheme = GoogleFonts.getTextTheme(
      displayFontString,
      textTheme,
    );
    TextTheme finalTextTheme = displayTextTheme.copyWith(
      bodyLarge: bodyTextTheme.bodyLarge,
      bodyMedium: bodyTextTheme.bodyMedium,
      bodySmall: bodyTextTheme.bodySmall,
      labelLarge: bodyTextTheme.labelLarge,
      labelMedium: bodyTextTheme.labelMedium,
      labelSmall: bodyTextTheme.labelSmall,
    );
    return finalTextTheme;
  }

  TargetPlatform get platform => theme.platform;
  ColorScheme get colorScheme => theme.colorScheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get mediaSize => mediaQuery.size;
  void showErrorBottomSheet({
    required ErrorBottomSheetData data,
    VoidCallback? onDismiss,
    bool isDismissible = true,
  }) => ErrorBottomSheet.show(
    this,
    data: data,
    onDismiss: onDismiss,
    isDismissible: isDismissible,
  );
  NavigatorState get navigationState => Navigator.of(this);
  Brightness get brightness => theme.brightness;
  bool get isDark => brightness == Brightness.dark;
}
