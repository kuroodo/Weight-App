import 'package:flutter/material.dart';

const homeScreen = "home_screen";
const resultScreen = "result_screen";
const resultInfoScreen = "result_info_screen";

class Navigation {
  static String _currentRoute = homeScreen;

  static String get currentRoute => _currentRoute;
  static bool get isHomeScreen => _currentRoute == homeScreen;
  static bool get isResultScreen => _currentRoute == resultScreen;
  static bool get isResultInfoScreen => _currentRoute == resultInfoScreen;

  static void popAndNavigateTo({
    required String route,
    required BuildContext context,
    Object? args,
  }) {
    _currentRoute = route;
    Navigator.of(context).popAndPushNamed(_currentRoute, arguments: args);
  }

  static void navigateTo({
    required String route,
    required BuildContext context,
    Object? args,
  }) {
    _currentRoute = route;
    Navigator.of(context).pushNamed(_currentRoute, arguments: args);
  }
}
