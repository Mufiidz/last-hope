import 'package:flutter/services.dart';

abstract class AppOrientation {
  static Future<void> portrait() => SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  static Future<void> landscape() => SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  static Future<void> normal() => SystemChrome.setPreferredOrientations([
    ...DeviceOrientation.values,
  ]);
}
