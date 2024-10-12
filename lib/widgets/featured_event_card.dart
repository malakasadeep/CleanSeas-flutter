import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clean_seas_flutter/models/event.dart';

class FeaturedEvent extends StatelessWidget {
  final Event event;
  final VoidCallback onTap; // Add a callback for the onTap action

  const FeaturedEvent({super.key, required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Use GestureDetector for tap detection
      onTap: onTap, // Call the onTap callback when tapped
      child: SizedBox(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    child: Container(
                      height: 85,
                      width: 80,
                      padding: const EdgeInsets.all(0),
                      child: Image.network(
                        event.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: GoogleFonts.raleway(
                          color: const Color.fromARGB(255, 6, 6, 6),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        event.location.toString(),
                        style: GoogleFonts.raleway(
                          color: const Color.fromARGB(255, 6, 6, 6),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        event.date,
                        style: GoogleFonts.raleway(
                          color: const Color.fromARGB(255, 20, 20, 20),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
