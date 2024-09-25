import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:clean_seas_flutter/controllers/user_controller.dart';
import 'package:clean_seas_flutter/models/user_model.dart';
import 'package:clean_seas_flutter/screens/authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:awesome_dialog/awesome_dialog.dart'; // Import AwesomeDialog

class UserRegForm extends StatefulWidget {
  const UserRegForm({super.key});

  @override
  _UserRegFormState createState() => _UserRegFormState();
}

class _UserRegFormState extends State<UserRegForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final UserController _userController = UserController();

  bool _isLoading = false; // Loading state

  void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        _showErrorDialog('Error', 'Passwords do not match');
        return;
      }

      UserModel user = UserModel(
        fullName: _fullNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        userType: 'volunteer',
      );

      setState(() {
        _isLoading = true; // Show loading spinner
      });

      try {
        await _userController.registerUser(user, context);
      } catch (error) {
        _showErrorDialog('Error', 'Registration failed. Please try again.');
      }

      setState(() {
        _isLoading = false; // Hide loading spinner
      });
    }
  }

  // Error Dialog
  void _showErrorDialog(String title, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: title,
      desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
      btnOkColor: Colors.red,
    ).show();
  }

  // Success Dialog

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sign up as a Volunteer..',
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _fullNameController,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.person, color: Colors.grey),
              labelText: 'Full Name',
              labelStyle: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.bold, color: darkBlue),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.mail, color: Colors.grey),
              labelText: 'Phone or Gmail',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold, color: darkBlue, fontSize: 17),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.visibility_off, color: Colors.grey),
              labelText: 'Password',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold, color: darkBlue, fontSize: 17),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.visibility_off, color: Colors.grey),
              labelText: 'Confirm Password',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold, color: darkBlue, fontSize: 17),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: _isLoading
                ? null
                : _registerUser, // Disable button when loading
            child: Container(
              height: 55,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(colors: [
                  Color.fromARGB(255, 94, 196, 230),
                  Color.fromARGB(255, 2, 4, 69),
                ]),
              ),
              child: Center(
                child: _isLoading
                    ? const SpinKitCircle(
                        // Loading spinner
                        color: Colors.white,
                        size: 30.0,
                      )
                    : const Text(
                        'SIGN UP',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const loginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
