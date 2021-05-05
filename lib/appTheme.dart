import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool isLightTheme = true;
  ThemeMode get currentTheme => isLightTheme ? ThemeMode.light : ThemeMode.dark;

  void toggleTheme() {
    isLightTheme = !isLightTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.black,
      accentColor: Colors.green,
      backgroundColor: Colors.white,
      appBarTheme: AppBarTheme(backgroundColor: Color(0xFF0BA1A5)),
      bottomAppBarColor: Color(0xFF2CC4CB),
      dividerColor: Colors.grey.shade300,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.black),
        headline2: TextStyle(color: Colors.black),
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.black,
      accentColor: Colors.red,
      backgroundColor: Colors.grey,
      bottomAppBarColor: Colors.grey,
      scaffoldBackgroundColor: Colors.grey,
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.white),
        headline2: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white),
      ),
    );
  }
}
