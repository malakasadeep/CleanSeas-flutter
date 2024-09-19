import 'dart:io';
import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:clean_seas_flutter/controllers/pollution_report_controller.dart';
import 'package:clean_seas_flutter/models/pollution_report.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

class ReportSummaryPage extends StatefulWidget {
  final String
      location; // This will be in "LatLng(5.9736354, 80.4656271)" format
  final String pollutionType;
  final double pollutionSeverity;
  final String description;
  final List<File> images;
  final DateTime incidentDate;
  final TimeOfDay? incidentTime;
  final String reporterName;
  final String contactInfo;

  ReportSummaryPage({
    required this.location,
    required this.pollutionType,
    required this.pollutionSeverity,
    required this.description,
    required this.images,
    required this.incidentDate,
    this.incidentTime,
    required this.reporterName,
    required this.contactInfo,
  });

  @override
  _ReportSummaryPageState createState() => _ReportSummaryPageState();
}

class _ReportSummaryPageState extends State<ReportSummaryPage> {
  String _formatIncidentTime(TimeOfDay? time) {
    if (time == null) return 'Not specified';
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dateTime); // Use `DateFormat.jm()` directly
  }

  final CarouselController _carouselController = CarouselController();
  final PollutionReportController _controller = PollutionReportController();
  bool _isLoading = false; // Loading state

  @override
  Widget build(BuildContext context) {
    double latitude = 0.0;
    double longitude = 0.0;

    try {
      // Parse the LatLng string format
      String cleanedLocation =
          widget.location.replaceAll(RegExp(r'LatLng\(|\)'), '');
      final locationParts = cleanedLocation.split(',');
      if (locationParts.length == 2) {
        latitude = double.parse(locationParts[0].trim());
        longitude = double.parse(locationParts[1].trim());
      }
    } catch (e) {
      print('Error parsing location: $e');
    }

    final CameraPosition _initialCameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14,
    );

    return Scaffold(
      backgroundColor: backgroundBlue,
      appBar: AppBar(
        backgroundColor: backgroundBlue,
        title: Text(
          'Report Summary',
          style: GoogleFonts.raleway(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(Iconsax.arrow_circle_left, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Iconsax.save_add, color: Colors.black),
                onPressed: _isLoading
                    ? null
                    : () async {
                        // Show confirmation dialog
                        bool? confirm = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Confirm'),
                              content:
                                  Text('Do you want to publish this report?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text('No'),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirm == true) {
                          setState(() {
                            _isLoading = true; // Set loading to true
                          });

                          // Create a PollutionReport instance
                          PollutionReport report = PollutionReport(
                            location: widget.location,
                            pollutionType: widget.pollutionType,
                            pollutionSeverity: widget.pollutionSeverity,
                            description: widget.description,
                            reporterName: widget.reporterName,
                            contactInfo: widget.contactInfo,
                            incidentDate: widget.incidentDate,
                            incidentTime: widget.incidentTime,
                          );

                          // Save report to Firestore and upload images
                          bool success = await _controller.saveReport(
                              report, widget.images);

                          setState(() {
                            _isLoading =
                                false; // Set loading to false after operation
                          });

                          // Show success or failure message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(success
                                  ? 'Report saved successfully!'
                                  : 'Failed to save report.'),
                            ),
                          );

                          if (success) {
                            Navigator.pop(
                                context); // Navigate back if successful
                          }
                        }
                      },
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading animation
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                // Carousel Slider for Images
                CarouselSlider(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    enlargeCenterPage: true,
                    autoPlay: false,
                  ),
                  items: widget.images.map((image) {
                    return Image.file(
                      image,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    '${widget.pollutionType} Pollution',
                    style: GoogleFonts.raleway(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                // Scrollable Container for the Summary Details
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
                              'Pollution Severity: ${_getSeverityLabel(widget.pollutionSeverity)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color:
                                    _getSeverityColor(widget.pollutionSeverity),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              ' ${widget.description}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: backgroundBlue,
                                  width: 2,
                                ),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Incident Date: ${DateFormat('yyyy-MM-dd').format(widget.incidentDate)}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  if (widget.incidentTime != null)
                                    Text(
                                      'Incident Time: ${_formatIncidentTime(widget.incidentTime)}',
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
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
                            SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: backgroundBlue,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.reporterName,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          widget.contactInfo,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    )
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

  String _getSeverityLabel(double value) {
    switch (value.toInt()) {
      case 1:
        return 'Low';
      case 2:
        return 'Moderate';
      case 3:
        return 'High';
      default:
        return 'Unknown';
    }
  }

  Color _getSeverityColor(double value) {
    switch (value.toInt()) {
      case 1:
        return Colors.green; // Low severity
      case 2:
        return Colors.orange; // Moderate severity
      case 3:
        return Colors.red; // High severity
      default:
        return Colors.grey; // Unknown severity
    }
  }
}
