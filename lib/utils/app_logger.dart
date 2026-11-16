import 'package:logger/logger.dart';

import 'string_ext.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount:
          2, // Jumlah baris stack trace yang ditampilkan (untuk klik file)
      errorMethodCount: 8, // Jumlah stack trace jika terjadi error
      lineLength: 120, // Lebar garis console
      colors: true, // Warna ANSI di console
      printEmojis: true, // Tampilkan emoji sesuai level log
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  /// Log dengan Tag dan Level DEBUG
  static void debug(dynamic message, {String? tag}) {
    _logger.d(tag.isNullOrEmpty() ? message : '[$tag] $message');
  }

  /// Log dengan Tag dan Level INFO
  static void info(dynamic message, {String? tag}) {
    _logger.i(tag.isNullOrEmpty() ? message : '[$tag] $message');
  }

  /// Log dengan Tag dan Level WARNING
  static void warn(dynamic message, {String? tag}) {
    _logger.w(tag.isNullOrEmpty() ? message : '[$tag] $message');
  }

  /// Log dengan Tag dan Level ERROR
  static void error(
    dynamic message, [
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _logger.e(tag.isNullOrEmpty() ? message : '[$tag] $message', error: error, stackTrace: stackTrace);
  }
}
