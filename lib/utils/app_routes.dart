import 'package:dic/screens/home.dart';
import 'package:dic/screens/login.dart';
import 'package:dic/screens/register.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = "/";
  static const String login = "/login";
  static const String register = "/register";
  static const String landingPage = "/landing";

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
  };
}
