import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:clean_seas_flutter/widgets/near_event_card.dart';
import 'package:clean_seas_flutter/models/event.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class OneEventScreen extends StatefulWidget {
  final Event event;
  const OneEventScreen({super.key, required this.event});

  @override
  State<OneEventScreen> createState() => _OneEventScreenState();
}

class _OneEventScreenState extends State<OneEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              NearEventCard(
                  event: widget.event,
                  wid: double.infinity,
                  hig: 420,
                  fsize: 1.4,
                  onTap: () {}),
              Positioned(
                width: 50,
                height: 50,
                top: 70,
                left: 30,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context); // Back navigation
                  },
                  child: const Icon(Iconsax.arrow_circle_left),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 0,
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: GoogleFonts.raleway(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'Description text goes here. This can be multi-line and provides details about the event.'
                              'Additional details about the event can be placed here.',
                              style: GoogleFonts.raleway(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: const Image(
                            image: AssetImage('assets/images/dp.png'),
                            width: 40,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mahinda Rajapakshe',
                              style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'NGO Bokka',
                              style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 92, 91, 91)),
                            ),
                          ],
                        ),
                        const SizedBox(width: 40),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Iconsax.call_add,
                            color: Color.fromARGB(255, 35, 21, 162),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Iconsax.archive_add,
                            color: Color.fromARGB(255, 35, 21, 162),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Image(image: AssetImage('assets/images/Map.png')),
                    const SizedBox(height: 10),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {},
                          child: Text(
                            '    Donate    ',
                            style: GoogleFonts.raleway(
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        const SizedBox(width: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Participate',
                            style: GoogleFonts.raleway(
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
