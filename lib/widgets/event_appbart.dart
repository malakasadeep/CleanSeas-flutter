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
    return GestureDetector(
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
      child: Row(
        children: [
          Text(
            'Hi ${loggedInUser.fullName.isNotEmpty ? loggedInUser.fullName : loggedInUser.ngoName}',
            style: GoogleFonts.raleway(
                fontSize: 30, fontWeight: FontWeight.w800, height: 1),
          ),
          const Spacer(),
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              "https://www.shareicon.net/data/512x512/2016/05/24/770117_people_512x512.png",
            ),
          ),
        ],
      ),
    );
  }
}
