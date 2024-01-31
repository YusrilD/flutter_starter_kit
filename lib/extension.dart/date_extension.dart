import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatIndonesianFullDate() {
    // Define days and months in Indonesian
    List<String> daysInIndonesian = [
      'Minggu',
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu'
    ];

    List<String> monthsInIndonesian = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];

    // Get day, month, and year components
    int day = this.day;
    int month = this.month;
    int year = this.year;

    // Format the date with Indonesian day and month names
    return "${daysInIndonesian[this.weekday - 1]}, $day ${monthsInIndonesian[month - 1]} $year";
  }

  String dashLocal() {
    // Format the date in DD-MM-YYYY
    return "${DateFormat('dd-MM-yyyy').format(this)}";
  }
}
