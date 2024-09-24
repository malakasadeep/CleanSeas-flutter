import 'dart:io';
import 'package:clean_seas_flutter/constants/colours.dart';
import 'package:clean_seas_flutter/controllers/pollution_report_controller.dart';
import 'package:clean_seas_flutter/models/pollution_report.dart';
import 'package:clean_seas_flutter/models/user_model.dart';
import 'package:clean_seas_flutter/screens/main_screen_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ReportSummaryPage extends StatefulWidget {
  final UserModel loggedInUser;
  final String location;
  final String pollutionType;
  final double pollutionSeverity;
  final String description;
  final List<File> images;
  final DateTime incidentDate;
  final TimeOfDay? incidentTime;
  final String city;
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
    required this.city,
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

  Color get darkBlue => Color(0xFF0B0672);
  Color get lightBlue => Color(0xFF5EC4E6);

  String _formatIncidentTime(TimeOfDay? time) {
    if (time == null) return 'Not specified';
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dateTime);
  }

  Future<void> _showConfirmationDialog() async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.scale,
      dialogBackgroundColor: Color.fromARGB(255, 192, 227, 255),
      title: 'Confirm Save',
      desc: 'Are you sure you want to save this report?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        _saveReport();
      },
    ).show();
  }

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
      city: widget.city,
    );

    bool success = await _controller.saveReport(report, widget.images);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      _showSuccessDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save report.')),
      );
    }
  }

  void _showSuccessDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      dialogBackgroundColor: Color.fromARGB(255, 192, 227, 255),
      title: 'Success!',
      desc: 'Your report has been successfully submitted.',
      btnOkOnPress: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MainScreenUser(loggedInUser: widget.loggedInUser),
          ),
        );
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    double latitude = 0.0;
    double longitude = 0.0;

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
          padding: const EdgeInsets.all(5.0),
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
            padding: const EdgeInsets.all(5.0),
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
                icon: Icon(Iconsax.document_upload, color: Colors.black),
                onPressed: _isLoading ? null : _showConfirmationDialog,
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: SpinKitCircle(
                color: darkBlue,
                size: 60,
              ),
            )
          : Column(
              children: [
                SizedBox(height: 20),
                CarouselSlider(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    height: 200,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    viewportFraction: 0.8,
                  ),
                  items: widget.images.map((image) {
                    return ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      child: Image.file(
                        image,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
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
                    decoration: BoxDecoration(
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
                            // Additional UI code continues
                            SizedBox(height: 10),
                            Text(
                              ' ${widget.description}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(32, 8.0, 32, 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: backgroundBlue,
                                    width: 2,
                                  ),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Iconsax.calendar_2_copy,
                                            color: const Color.fromARGB(
                                                255, 59, 107, 147)),
                                        Text(
                                          ' ${DateFormat('yyyy-MM-dd').format(widget.incidentDate)}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    if (widget.incidentTime != null)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Iconsax.clock_copy,
                                              color: const Color.fromARGB(
                                                  255, 59, 107, 147)),
                                          Text(
                                            ' ${_formatIncidentTime(widget.incidentTime)}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Iconsax.location_copy,
                                            color: Color.fromARGB(
                                                255, 6, 64, 111)),
                                        Text(
                                          ' ${widget.city}',
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
                                height: 250,
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: GoogleMap(
                                    initialCameraPosition:
                                        _initialCameraPosition,
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
                                              widget.reporterName,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              widget.contactInfo,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w200,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 100,
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
    );
  }

  String _getSeverityLabel(double value) {
    if (value == 3) return 'High';
    if (value == 2) return 'Moderate';
    return 'Low';
  }

  Color _getSeverityColor(double value) {
    if (value == 3) return Colors.red;
    if (value == 2) return Colors.orange;
    return Colors.green;
  }
}
