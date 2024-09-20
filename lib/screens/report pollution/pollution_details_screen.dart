import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class PollutionDetailsPage extends StatelessWidget {
  final String reportId;
  final Map<String, dynamic> reportData;
  final CarouselController _carouselController = CarouselController();

  PollutionDetailsPage({
    required this.reportId,
    required this.reportData,
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
                padding: const EdgeInsets.all(16.0),
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
                      ),
                      SizedBox(height: 20),
                      Container(
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
                            Text(
                              'Incident Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(reportData['incidentDate']))}',
                              style: TextStyle(fontSize: 16),
                            ),
                            if (incidentTime != null)
                              Text(
                                'Incident Time: ${_formatIncidentTime(incidentTime)}',
                                style: TextStyle(fontSize: 16),
                              ),
                          ],
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
                      Container(
                        height: 300,
                        width: double.infinity,
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
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF5EC4E6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  "https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359554_1280.png",
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reportData['reporterName'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    reportData['contactInfo'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54,
                                    ),
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
    );
  }
}