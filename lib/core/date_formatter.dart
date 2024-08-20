import 'package:intl/intl.dart';

class DateFormatter {
  static String format(DateTime date) {
    return DateFormat('EEEE, d MMMM').format(date);
  }

  static String getDay(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  static String getHourAmFormat(DateTime date) {
    return DateFormat('h').format(date);
  }

  static String getAmPm(DateTime date) {
    return DateFormat('a').format(date);
  }
}
