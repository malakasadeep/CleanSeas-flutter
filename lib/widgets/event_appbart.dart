import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventAppBar extends StatelessWidget {
  const EventAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Hi Rajapakshe',
          style: GoogleFonts.raleway(
              fontSize: 30, fontWeight: FontWeight.w800, height: 1),
        ),
        const Spacer(),
        Image(image: AssetImage('assets/images/mahiiicat.png'))
      ],
    );
  }
}
