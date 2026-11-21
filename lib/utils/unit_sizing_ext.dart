import 'package:material_ui/material_ui.dart';

extension UnitSizing on num {
  /// Satuan logical pixel (dp) di Flutter.
  /// Mengembalikan `double` agar siap dipakai di EdgeInsets, SizedBox, dll.
  // double get dp => toDouble();

  /// Scaled Pixel (.sp) yang mengikuti pengaturan ukuran font sistem (textScaler).
  double sp(BuildContext context) {
    return MediaQuery.textScalerOf(context).scale(toDouble());
  }
}
