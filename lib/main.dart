import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Function Sun App Starter Kit',
      home: Dashboard(),
    );
  }
}
