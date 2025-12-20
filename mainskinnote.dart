import 'package:flutter/material.dart';
import 'Màn hình chính/StatelessWidget.dart'; // Welcome
import 'Màn hình chính/Login.dart';

void main() {
  runApp(const MyApp());
}

/// Root app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkinNote',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Segoe UI',
      ),
      home: const WelcomePage(), // 👈 MÀN HÌNH ĐẦU TIÊN
    );
  }
}
