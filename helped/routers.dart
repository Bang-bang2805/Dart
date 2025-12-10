import 'package:firstproject/widgets/login_page.dart' show LoginPage;
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

// sửa lại tên package cho đúng dự án firstproject
import 'package:firstproject/widgets/login_page.dart';
import 'package:firstproject/widgets/register_page.dart';

class AppRouter {
  static final FluroRouter router = FluroRouter();

  static final Handler _loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const LoginPage(title: "Đăng nhập");
    },
  );

  static final Handler _registerHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const RegisterPage(title: "Đăng ký");
    },
  );

  static void setupRouter() {
    router.define(
      '/login',
      handler: _loginHandler,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      '/register',
      handler: _registerHandler,
      transitionType: TransitionType.fadeIn,
    );
  }
}
