import 'package:clean_seas_flutter/screens/authentication/login_screen.dart';
import 'package:clean_seas_flutter/screens/main_screen_user.dart';
import 'package:clean_seas_flutter/screens/ngo_main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:clean_seas_flutter/models/user_model.dart';

class UserController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser(UserModel user, BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(user.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Successful')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => loginScreen(),
          // Navigate to login screen
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    }
  }

  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    try {
      // Attempt to sign in the user with the provided credentials
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // Retrieve the user details from Firestore
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(firebaseUser.uid).get();

        if (userDoc.exists) {
          // Create a UserModel object from Firestore data
          UserModel loggedInUser =
              UserModel.fromMap(userDoc.data() as Map<String, dynamic>);

          // Navigate based on user type
          if (loggedInUser.userType == 'volunteer') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MainScreenUser(loggedInUser: loggedInUser),
              ),
            );
          } else if (loggedInUser.userType == 'ngo') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NgoMainScreen(loggedInUser: loggedInUser),
              ),
            );
          } else {
            _showErrorDialog(context, 'Unknown user type.');
          }
        } else {
          _showErrorDialog(context, 'User data not found.');
        }
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
      _showErrorDialog(context, 'Login failed: ${e.message}');
    } catch (e) {
      // Handle general errors
      _showErrorDialog(context, 'An error occurred: $e');
    }
  }

  // Method to show error alert dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> logoutUser(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => loginScreen(),
          // Navigate to login screen
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $e')),
      );
    }
  }
}
