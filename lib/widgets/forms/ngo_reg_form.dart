import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:clean_seas_flutter/screens/authentication/login_screen.dart';
import 'package:flutter/material.dart';

class NgoRegForm extends StatelessWidget {
  const NgoRegForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Sign up as a NGO..',
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const TextField(
          decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.group,
                color: Colors.grey,
              ),
              label: Text(
                'NGO Name',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: darkBlue,
                ),
              )),
        ),
        const TextField(
          decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.app_registration,
                color: Colors.grey,
              ),
              label: Text(
                'Registration No',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: darkBlue,
                ),
              )),
        ),
        const TextField(
          decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.mail,
                color: Colors.grey,
              ),
              label: Text(
                'Phone or Gmail',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: darkBlue, fontSize: 17),
              )),
        ),
        const TextField(
          decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.visibility_off,
                color: Colors.grey,
              ),
              label: Text(
                'Password',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: darkBlue, fontSize: 17),
              )),
        ),
        const TextField(
          decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.visibility_off,
                color: Colors.grey,
              ),
              label: Text(
                'Conform Password',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: darkBlue, fontSize: 17),
              )),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 55,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 94, 196, 230),
              Color.fromARGB(255, 2, 4, 69),
            ]),
          ),
          child: const Center(
            child: Text(
              'SIGN UP',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Already have an account?",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return loginScreen(); // Add const here if loginScreen has a const constructor
                      },
                    ),
                  );
                },
                child: Text(
                  // This can remain const as it does not depend on runtime values
                  "Sign In",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
