
import 'package:clean_seas_flutter/screens/authentication/login_screen.dart';
import 'package:clean_seas_flutter/screens/authentication/reg_screen.dart';
import 'package:clean_seas_flutter/screens/event/one_event_screen.dart';
import 'package:clean_seas_flutter/screens/main_screen.dart';

import 'package:clean_seas_flutter/screens/onboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'poppins'),
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
