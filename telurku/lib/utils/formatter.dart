import 'package:intl/intl.dart';

class Formatter {
  static String currency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(amount);
  }

  static String date(DateTime date) {
    return DateFormat('dd MMM yyyy', 'id_ID').format(date);
  }
}
