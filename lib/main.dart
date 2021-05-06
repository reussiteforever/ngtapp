import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngtapp/appTheme.dart';
import 'package:ngtapp/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/bottomTab/bottomTabScreen.dart';
import 'screens/list/listScreen.dart';
import 'screens/login/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic loginToken;

  getLoginToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      loginToken = sharedPreferences.getString("token");
      print(loginToken);
    });
  }

  @override
  void initState() {
    super.initState();
    getLoginToken();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          CustomTheme.isLightTheme ? Brightness.dark : Brightness.light,
      statusBarBrightness:
          CustomTheme.isLightTheme ? Brightness.light : Brightness.dark,
      systemNavigationBarColor:
          CustomTheme.isLightTheme ? Colors.white : Colors.black,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness:
          CustomTheme.isLightTheme ? Brightness.dark : Brightness.light,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NGT APP',
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
      // home: SplashScreen(),
      home: loginToken != null ? BottomTabScreen() : SplashScreen(),
    );
  }
}
