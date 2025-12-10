import 'package:flutter/material.dart';
import 'package:firstproject/widgets/dashboard.dart';
import 'ueh mobile/register.dart';
import 'ueh mobile/login.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(title: "Đăng ký"),
        '/dashboard': (context) => DashboardScreen(),
      },
    ),
  );
}
