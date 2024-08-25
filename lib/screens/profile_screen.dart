import 'package:clean_seas_flutter/models/user_model.dart';
import 'package:clean_seas_flutter/widgets/profile/user_profile.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel loggedInUser;
  const ProfileScreen({super.key, required this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    return UserProfile(
      loggedInUser: loggedInUser,
    );
  }
}
