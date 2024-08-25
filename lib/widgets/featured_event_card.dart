import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturedEvent extends StatelessWidget {
  const FeaturedEvent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(7),
            child: Row(
              children: [
                Container(
                  height: 85,
                  width: 80,
                  padding: const EdgeInsets.all(2),
                  child: Image.asset('assets/images/eventimg1.png'),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kamilo Beach, Hawaii',
                      style: GoogleFonts.raleway(
                        color: Color.fromARGB(255, 6, 6, 6),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'kukku chuttak ona',
                      style: GoogleFonts.raleway(
                        color: Color.fromARGB(255, 20, 20, 20),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
