import 'package:intl/intl.dart';

String getCoupleTime(DateTime date) {
  return DateFormat.Hm().format(date);
}
