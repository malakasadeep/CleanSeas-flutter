import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:clean_seas_flutter/screens/event/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:clean_seas_flutter/widgets/near_event_card.dart';
import 'package:clean_seas_flutter/models/event.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart'; // Import for launching URLs

class OneEventScreen extends StatefulWidget {
  final Event event;
  const OneEventScreen({super.key, required this.event});

  @override
  State<OneEventScreen> createState() => _OneEventScreenState();
}

class _OneEventScreenState extends State<OneEventScreen> {
  late GoogleMapController mapController;

  final LatLng _eventLocation =
      const LatLng(6.9271, 79.8612); // Event's latitude and longitude

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Method to launch email
  void _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'weerakkodyse@gmail.com',
      query: Uri.encodeQueryComponent(
          'subject=Participate in Marissa Cleaning Event&body=I would like to participate in the event Marissa Cleaning Event.'),
    );

    try {
      await launchUrl(emailLaunchUri);
    } catch (e) {
      print('Could not launch $emailLaunchUri: $e');
      // You can also show a Snackbar or AlertDialog to inform the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Could not launch email client. Please ensure an email app is installed.')),
      );
    }
  }

  void _navigateToPaymentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentPage()),
    );
  }

  // Method to show confirmation dialog
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?',
              style: GoogleFonts.raleway(fontWeight: FontWeight.bold)),
          content: Text('Do you want to participate in this event?',
              style: GoogleFonts.raleway(fontWeight: FontWeight.bold)),
          actions: [
            TextButton(
              child: Text('Cancel',
                  style: GoogleFonts.raleway(
                      color: Colors.red, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Yes',
                  style: GoogleFonts.raleway(
                      color: Colors.green, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _sendEmail(); // Send the email
              },
            ),
          ],
        );
      },
    );
  }

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
                onTap: () {},
              ),
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
                            left: 15, right: 15, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: GoogleFonts.raleway(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              widget.event.description,
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
                    // Google Map with rounded corners and margin
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                          ),
                          child: GoogleMap(
                            onMapCreated: _onMapCreated,
                            initialCameraPosition: CameraPosition(
                              target: _eventLocation,
                              zoom: 14.0,
                            ),
                            markers: {
                              Marker(
                                markerId: MarkerId('eventLocation'),
                                position: _eventLocation,
                                infoWindow: InfoWindow(
                                  title: widget.event.title,
                                  snippet: 'Event Location',
                                ),
                              ),
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: _navigateToPaymentPage,
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
                          onPressed:
                              _showConfirmationDialog, // Show confirmation dialog
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
