import 'package:intl/intl.dart';

class Util {
  String getCurrentHour() {
    DateTime now = DateTime.now();
    String currentHour = DateFormat('kk:mm').format(now);
    return currentHour;
  }
}
