import 'package:intl/intl.dart';

import 'default_value.dart';
import 'export_utils.dart';

extension DatetimeExt on DateTime? {
  String toRelativeTime({String? locale}) {
    final value = this;
    if (value == null) {
      return dashString();
    }
    final now = DateTime.now();
    final localDate = value.toLocal();
    final difference = now.difference(localDate);
    final currentLocale = locale ?? Intl.systemLocale;

    if (difference.isNegative || difference.inSeconds < 60) {
      return 'now';
    }

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    }

    if (difference.inHours < 24) {
      return '${difference.inHours}h';
    }

    if (difference.inDays < 7) {
      return '${difference.inDays}d';
    }

    return DateFormat('dd/MM/yy', currentLocale).format(localDate);
  }
}
