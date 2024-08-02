// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:clean_seas_flutter/constants/string.dart';
import 'package:flutter/material.dart';

class Onboarding01 extends StatelessWidget {
  const Onboarding01({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Spacer(),
          Image.asset(
            'assets/images/onboardimg1.png',
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Clean Beaches\nEasily & efficiently',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.values[8],
                    color: textblack,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  onboarddes01,
                  style: TextStyle(
                    fontSize: 16,
                    color: textblack,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.circle, size: 10, color: textorange),
              SizedBox(width: 5),
              Icon(Icons.circle, size: 10, color: textblack),
              SizedBox(width: 5),
              Icon(Icons.circle, size: 10, color: textblack),
            ],
          ),
          Spacer(),

          Container(
            width: double.infinity,
            height: 50,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: textblack),
            child: Center(
              child: Text(
                "Get Started",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 25),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
