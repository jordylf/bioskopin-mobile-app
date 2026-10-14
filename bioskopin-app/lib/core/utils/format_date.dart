// Package imports:
import 'package:intl/intl.dart';

class FormatDateUtil {
  static String formatDateTime(String dateTime) {
    final DateTime date = DateTime.parse(dateTime).toUtc();
    final DateTime dateLocal = date.add(const Duration(hours: 7));

    final DateFormat formatter = DateFormat('dd MMMM yyyy HH:mm', 'id_ID');

    return formatter.format(dateLocal);
  }
}
