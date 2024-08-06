import 'package:clean_seas_flutter/screens/authentication/login_screen.dart';
import 'package:clean_seas_flutter/screens/authentication/reg_screen.dart';
import 'package:clean_seas_flutter/screens/onboard_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'jua'),
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
    );
  }
}
