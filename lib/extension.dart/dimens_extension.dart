import 'package:flutter/material.dart';

extension DimensExtension on BuildContext {
  double get appWidth => MediaQuery.of(this).size.width;
  double get appHeight => MediaQuery.of(this).size.height;
}
