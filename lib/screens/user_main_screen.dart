import 'package:clean_seas_flutter/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:clean_seas_flutter/models/user_model.dart';

class UserMainScreen extends StatelessWidget {
  final UserModel loggedInUser;

  const UserMainScreen({super.key, required this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          child: Text('WelcomeUser, ${loggedInUser.fullName}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ProfileScreen(
                    loggedInUser: loggedInUser,
                  ); // Add const here if loginScreen has a const constructor
                },
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full Name: ${loggedInUser.fullName}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: ${loggedInUser.email}',
              style: TextStyle(fontSize: 18),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
