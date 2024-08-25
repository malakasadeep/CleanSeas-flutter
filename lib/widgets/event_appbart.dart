import 'package:clean_seas_flutter/models/user_model.dart';
import 'package:clean_seas_flutter/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventAppBar extends StatelessWidget {
  final UserModel loggedInUser;
  const EventAppBar({
    super.key,
    required this.loggedInUser,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: Text(
            'Hi ${loggedInUser.fullName}',
            style: GoogleFonts.raleway(
                fontSize: 30, fontWeight: FontWeight.w800, height: 1),
          ),
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
        const Spacer(),
        Image(image: AssetImage('assets/images/mahiiicat.png'))
      ],
    );
  }
}
