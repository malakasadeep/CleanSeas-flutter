import 'dart:io';
import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:clean_seas_flutter/controllers/pollution_report_controller.dart';
import 'package:clean_seas_flutter/models/pollution_report.dart';
import 'package:clean_seas_flutter/models/user_model.dart';
import 'package:clean_seas_flutter/screens/main_screen_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

class ReportSummaryPage extends StatefulWidget {
  final UserModel loggedInUser;
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
    super.key,
    required this.location,
    required this.pollutionType,
    required this.pollutionSeverity,
    required this.description,
    required this.images,
    required this.incidentDate,
    this.incidentTime,
    required this.reporterName,
    required this.contactInfo,
    required this.loggedInUser,
  });

  @override
  _ReportSummaryPageState createState() => _ReportSummaryPageState();
}

class _ReportSummaryPageState extends State<ReportSummaryPage> {
  final CarouselController _carouselController = CarouselController();
  final PollutionReportController _controller = PollutionReportController();
  bool _isLoading = false;

  // Define the new colors
  Color get darkBlue => Color(0xFF0B0672);
  Color get lightBlue => Color(0xFF5EC4E6);

  // Format incident time
  String _formatIncidentTime(TimeOfDay? time) {
    if (time == null) return 'Not specified';
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dateTime);
  }

  // Show confirmation dialog before saving the report
  Future<void> _showConfirmationDialog() async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Confirm Save',
          style: TextStyle(color: darkBlue),
        ),
        content: Text(
          'Are you sure you want to save this report?',
          style: TextStyle(color: darkBlue),
        ),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Confirm
            },
            child: Text(
              'Yes',
              style: TextStyle(color: darkBlue),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Cancel
            },
            child: Text(
              'No',
              style: TextStyle(color: darkBlue),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      _saveReport(); // Proceed to save the report if confirmed
    }
  }

  // Function to save the report and show success dialog
  Future<void> _saveReport() async {
    setState(() {
      _isLoading = true;
    });

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
    bool success = await _controller.saveReport(report, widget.images);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      _showSuccessDialog(); // Show success alert and navigate to UserMainScreen
    } else {
      // Show failure message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save report.')),
      );
    }
  }

  // Show success alert dialog after saving report
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Success!',
          style: TextStyle(color: lightBlue),
        ),
        content: Text(
          'Your report has been successfully submitted.',
          style: TextStyle(color: darkBlue),
        ),
        backgroundColor: Colors.white, // Background color with light blue tint
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MainScreenUser(loggedInUser: widget.loggedInUser),
                ),
              ); // Navigate to UserMainScreen
            },
            child: Text(
              'OK',
              style: TextStyle(color: darkBlue),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double latitude = 0.0;
    double longitude = 0.0;

    // Parse the LatLng from the string
    try {
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
        title: Text(
          'Report Summary',
          style: GoogleFonts.raleway(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        backgroundColor: backgroundBlue,
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
                  offset: Offset(0, 0),
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
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Iconsax.save_add, color: Colors.black),
                onPressed: _isLoading ? null : _showConfirmationDialog,
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: darkBlue, // Use darkBlue for loading indicator
              ),
            )
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
    // Return severity label based on the pollution severity value
    if (value == 3) {
      return 'High';
    } else if (value == 2) {
      return 'Moderate';
    } else {
      return 'Low';
    }
  }

  Color _getSeverityColor(double value) {
    // Return color based on pollution severity value
    if (value == 3) {
      return Colors.red;
    } else if (value == 2) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }
}
