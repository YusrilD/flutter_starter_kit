import 'package:flutter/material.dart';

extension StringExtension on String {
  // Capitalize first letter of each word
  String get toTitleCase {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : '')
        .join(' ');
  }

  // Capitalize first letter
  String get capitalizeFirst {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  // Check if string is email
  bool get isEmail {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    return emailRegExp.hasMatch(this);
  }

  // Check if string is phone number
  bool get isPhoneNumber {
    final phoneRegExp = RegExp(r'^\+?[\d-]{10,}$');
    return phoneRegExp.hasMatch(this);
  }

  // Check if string is URL
  bool get isURL {
    final urlRegExp = RegExp(
      r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$',
    );
    return urlRegExp.hasMatch(this);
  }

  // Remove all whitespace
  String get removeAllWhitespace => replaceAll(RegExp(r'\s+'), '');

  // Convert to Color
  Color? get toColor {
    final hexCode = replaceAll('#', '');
    if (hexCode.length == 6) {
      return Color(int.parse('FF$hexCode', radix: 16));
    } else if (hexCode.length == 8) {
      return Color(int.parse(hexCode, radix: 16));
    }
    return null;
  }

  // Mask credit card number
  String get maskCreditCard {
    if (length < 4) return this;
    return '****${substring(length - 4)}';
  }

  // Convert to slug
  String get toSlug {
    return toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-');
  }

  // Truncate string with ellipsis
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }

  // Check if string contains only numbers
  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  // Format as currency (assuming input is numeric)
  String formatAsCurrency({String symbol = '\$'}) {
    if (!isNumeric) return this;
    final number = double.parse(this);
    return '$symbol${number.toStringAsFixed(2)}';
  }
} 