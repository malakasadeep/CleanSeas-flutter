import 'package:clean_seas_flutter/widgets/forms/login_form.dart';
import 'package:flutter/material.dart';
// Import the MainPage widget

class loginScreen extends StatelessWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 94, 196, 230),
                      Color.fromARGB(255, 2, 4, 69),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 1,
                  ),
                ),
              ),
            ),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
