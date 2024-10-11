import 'package:clean_seas_flutter/screens/event/create_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:clean_seas_flutter/models/user_model.dart'; // Assuming you have a UserModel

class PollutionDetailsPage extends StatelessWidget {
  final String reportId;
  final Map<String, dynamic> reportData;
  final UserModel loggedInUser; // Add logged-in user info here
  final CarouselController _carouselController = CarouselController();

  PollutionDetailsPage({
    required this.reportId,
    required this.reportData,
    required this.loggedInUser, // Pass the logged-in user info
  });

  String _getSeverityLabel(double severity) {
    if (severity == 3) return 'High';
    if (severity == 2) return 'Moderate';
    return 'Low';
  }

  Color _getSeverityColor(double severity) {
    if (severity == 3) return Colors.red;
    if (severity == 2) return Colors.orange;
    return Colors.green;
  }

  // Convert String to TimeOfDay
  TimeOfDay? _parseIncidentTime(String? timeString) {
    if (timeString == null) return null;
    try {
      final timeParts = timeString.split(':');
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      print('Error parsing incident time: $e');
      return null;
    }
  }

  String _formatIncidentTime(TimeOfDay? time) {
    if (time == null) return 'Not specified';
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dateTime); // Formats to AM/PM style
  }

  @override
  Widget build(BuildContext context) {
    double latitude = 0;
    double longitude = 0;

    try {
      String cleanedLocation =
          reportData['location'].replaceAll(RegExp(r'LatLng\(|\)'), '');
      final locationParts = cleanedLocation.split(',');
      latitude = double.parse(locationParts[0].trim());
      longitude = double.parse(locationParts[1].trim());
    } catch (e) {
      print('Error parsing location: $e');
    }

    final CameraPosition _initialCameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14,
    );

    // Parse incident time (if provided as string)
    TimeOfDay? incidentTime = _parseIncidentTime(reportData['incidentTime']);

    return Scaffold(
      backgroundColor: backgroundBlue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Carousel Slider for images
              CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: 270,
                  aspectRatio: 16 / 12,
                  viewportFraction: 1.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                ),
                items:
                    (reportData['imageUrls'] as List<dynamic>).map((imageUrl) {
                  return ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  );
                }).toList(),
              ),
              // Back Button on top of the images
              Positioned(
                top: 30,
                left: 10,
                child: FloatingActionButton(
                  heroTag: "back",
                  onPressed: () {
                    Navigator.pop(context); // Back navigation
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(Iconsax.arrow_circle_left,
                      color: Colors.black),
                ),
              ),
              // Navigation arrows for carousel
              Positioned(
                top: 100,
                right: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_forward, color: Colors.black),
                      onPressed: () {
                        _carouselController.nextPage();
                      },
                    ),
                    SizedBox(height: 10),
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        _carouselController.previousPage();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              '${reportData['pollutionType']} Pollution',
              style: GoogleFonts.raleway(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Severity: ${_getSeverityLabel(reportData['pollutionSeverity'])}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: _getSeverityColor(
                              reportData['pollutionSeverity']),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${reportData['description']}',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 20),
                      // Incident Date and Time
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32.0, 0, 32, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0xFF5EC4E6),
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Iconsax.calendar_2_copy,
                                      color: Color.fromARGB(255, 6, 64, 111)),
                                  Text(
                                    ' ${DateFormat('yyyy-MM-dd').format(DateTime.parse(reportData['incidentDate']))}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              if (incidentTime != null)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Iconsax.clock_copy,
                                        color: Color.fromARGB(255, 6, 64, 111)),
                                    Text(
                                      ' ${_formatIncidentTime(incidentTime)}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Iconsax.location_copy,
                                      color: Color.fromARGB(255, 6, 64, 111)),
                                  Text(
                                    ' In ${reportData['city']}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Location:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          height: 250,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: GoogleMap(
                              initialCameraPosition: _initialCameraPosition,
                              markers: {
                                Marker(
                                  markerId: MarkerId('reportLocation'),
                                  position: LatLng(latitude, longitude),
                                ),
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Divider(
                                color: backgroundBlue,
                                thickness: 3,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 23,
                                    backgroundImage: NetworkImage(
                                      "https://www.shareicon.net/data/512x512/2016/05/24/770117_people_512x512.png",
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${reportData['reporterName']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        '${reportData['contactInfo']}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w200,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Icon(
                                    Iconsax.send_1,
                                    color: Colors.black,
                                    size: 28,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: loggedInUser.userType == 'ngo'
          ? FloatingActionButton(
              heroTag: 'reportEvent',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateEventScreen()));
              },
              backgroundColor: Colors.blue,
              child: Icon(Iconsax.calendar_add, color: Colors.white),
            )
          : null, // Show FAB only for NGO users
    );
  }
}
