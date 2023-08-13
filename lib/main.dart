import 'package:scan/pages/home.dart';
import 'package:scan/pages/intro.dart';
import 'package:scan/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:scan/utils/themes.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      home: HomeScreen(),
    );
  }
}
