import 'package:flutter/material.dart';
import 'package:clean_seas_flutter/models/event.dart';
import 'package:google_fonts/google_fonts.dart';

class NearEventCard extends StatelessWidget {
  final Event event;
  final double wid;
  final double hig;
  final double fsize;
  final VoidCallback onTap;

  const NearEventCard({
    super.key,
    required this.event,
    required this.wid,
    required this.hig,
    required this.fsize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: wid,
        height: hig,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  event.image,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.85),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Aligns children to the left
                  children: [
                    // Event Title
                    Text(
                      event.title,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 15 * fsize,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 10),
                    Text(
                      event.description,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 12 * fsize,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign
                          .left, // Aligns text to the left inside the Text widget
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
