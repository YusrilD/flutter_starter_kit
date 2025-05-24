import 'dart:math';

import 'package:intl/intl.dart';

extension NumExtension on num {
  // Format number with thousands separator
  String get formatWithCommas {
    return NumberFormat('#,##0').format(this);
  }

  // Format as currency
  String formatAsCurrency({String symbol = '\$', int decimalPlaces = 2}) {
    return NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalPlaces,
    ).format(this);
  }

  // Convert to percentage
  String toPercentage({int decimalPlaces = 1}) {
    return '${(this * 100).toStringAsFixed(decimalPlaces)}%';
  }

  // Format file size
  String get formatFileSize {
    if (this < 1024) return '${toStringAsFixed(0)} B';
    if (this < 1024 * 1024) return '${(this / 1024).toStringAsFixed(1)} KB';
    if (this < 1024 * 1024 * 1024) {
      return '${(this / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(this / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  // Duration extensions
  Duration get milliseconds => Duration(milliseconds: toInt());
  Duration get seconds => Duration(seconds: toInt());
  Duration get minutes => Duration(minutes: toInt());
  Duration get hours => Duration(hours: toInt());
  Duration get days => Duration(days: toInt());

  // Temperature conversions
  double get celsiusToFahrenheit => (this * 9 / 5) + 32;
  double get fahrenheitToCelsius => (this - 32) * 5 / 9;

  // Angle conversions
  double get degreesToRadians => this * (3.141592653589793 / 180);
  double get radiansToDegrees => this * (180 / 3.141592653589793);

  // Round to specific decimal places
  double roundTo(int places) {
    num mod = pow(10.0, places);
    return ((this * mod).round().toDouble() / mod);
  }

  // Check if number is between range
  bool isBetween(num from, num to) {
    return from <= this && this <= to;
  }
}

extension DoubleExtension on double {
  // Round to specific decimal places
  String toStringWithPrecision(int precision) {
    return toStringAsFixed(
      truncateToDouble() == this ? 0 : precision,
    );
  }
}

// Extension for integer specific operations
extension IntExtension on int {
  // Check if number is prime
  bool get isPrime {
    if (this <= 1) return false;
    if (this == 2) return true;
    if (this % 2 == 0) return false;
    
    for (int i = 3; i <= sqrt(this); i += 2) {
      if (this % i == 0) return false;
    }
    return true;
  }

  // Get factorial
  int get factorial {
    if (this < 0) throw Exception('Factorial is not defined for negative numbers');
    if (this == 0) return 1;
    return this * (this - 1).factorial;
  }

  // Convert to roman numeral
  String get toRoman {
    if (this < 1 || this > 3999) {
      throw Exception('Number must be between 1 and 3999');
    }

    const romans = {
      1000: 'M',
      900: 'CM',
      500: 'D',
      400: 'CD',
      100: 'C',
      90: 'XC',
      50: 'L',
      40: 'XL',
      10: 'X',
      9: 'IX',
      5: 'V',
      4: 'IV',
      1: 'I',
    };

    var num = this;
    var result = '';

    for (var value in romans.keys) {
      while (num >= value) {
        result += romans[value]!;
        num -= value;
      }
    }

    return result;
  }
} 