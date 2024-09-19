import 'dart:io';
import 'package:clean_seas_flutter/screens/report%20pollution/location_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; // For Date formatting
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class ReportPollutionScreen extends StatefulWidget {
  @override
  _ReportPollutionScreenState createState() => _ReportPollutionScreenState();
}

class _ReportPollutionScreenState extends State<ReportPollutionScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _location;
  String? _pollutionType;
  double _pollutionSeverity = 1.0;
  String? _description;
  List<File> _images = [];
  DateTime? _incidentDate;
  TimeOfDay? _incidentTime;
  String? _waterCondition;
  String? _reporterName = "John Doe"; // This will come from Firebase user info
  String? _contactInfo = "johndoe@example.com"; // Also from Firebase user info

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white, // Text color on the button
    );
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.white, // Background color for inputs
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: darkBlue),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
    );

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Report Marine Pollution'),
      //   backgroundColor: darkBlue, // Matching app bar color
      // ),
      backgroundColor: backgroundBlue,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 50.0, 12.0, 2.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context); // Back navigation
                      },
                      backgroundColor: Colors.white,
                      child: const Icon(Iconsax.arrow_circle_left,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Report Marine Pollution',
                    style: GoogleFonts.raleway(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(color: backgroundBlue),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Pollution Category Dropdown
                      DropdownButtonFormField<String>(
                        items: [
                          'Plastics and Debris',
                          'Oil Spillage',
                          'Chemicals and Hazardous Waste',
                          'Abandoned Fishing Gear',
                          'Sewage or Wastewater',
                          'Other'
                        ]
                            .map((e) => DropdownMenuItem(
                                child:
                                    Text(e, style: TextStyle(color: textblack)),
                                value: e))
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _pollutionType = val),
                        decoration: inputDecoration.copyWith(
                          labelText: 'Pollution Type',
                        ),
                        validator: (value) => value == null
                            ? 'Please select a pollution type'
                            : null,
                      ),

                      SizedBox(height: 20),

                      // Date Picker
                      TextFormField(
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now());
                          if (pickedDate != null) {
                            setState(() {
                              _incidentDate = pickedDate;
                            });
                          }
                        },
                        decoration: inputDecoration.copyWith(
                          labelText: 'Date of Incident',
                          prefixIcon: Icon(Iconsax.calendar, color: darkBlue),
                          hintText: _incidentDate != null
                              ? DateFormat('yyyy-MM-dd').format(_incidentDate!)
                              : "Pick a date",
                        ),
                        validator: (value) =>
                            _incidentDate == null ? 'Date is required' : null,
                      ),

                      SizedBox(height: 20),

                      // Time Picker (Optional)
                      TextFormField(
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          if (pickedTime != null) {
                            setState(() {
                              _incidentTime = pickedTime;
                            });
                          }
                        },
                        decoration: inputDecoration.copyWith(
                          labelText: 'Time of Incident (Optional)',
                          prefixIcon: Icon(Iconsax.clock, color: darkBlue),
                          hintText: _incidentTime != null
                              ? _incidentTime!.format(context)
                              : "Pick a time",
                        ),
                      ),

                      SizedBox(height: 20),
                      // Water Condition Dropdown
                      DropdownButtonFormField<String>(
                        items: [
                          'Clear',
                          'Murky',
                          'Oily sheen',
                          'Debris-filled',
                        ]
                            .map((e) => DropdownMenuItem(
                                child:
                                    Text(e, style: TextStyle(color: textblack)),
                                value: e))
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _waterCondition = val),
                        decoration: inputDecoration.copyWith(
                          labelText: 'Water Condition',
                        ),
                        validator: (value) => value == null
                            ? 'Please select water condition'
                            : null,
                      ),

                      SizedBox(height: 20),
                      // Description
                      TextFormField(
                        maxLines: 3,
                        decoration: inputDecoration.copyWith(
                          labelText: 'Description',
                        ),
                        onChanged: (val) => _description = val,
                        validator: (value) =>
                            value!.isEmpty ? 'Description is required' : null,
                      ),

                      SizedBox(height: 20),
                      // Location Picker Field
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _location ?? "Pick a location",
                              style: theme.textTheme.titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ]),
                            child: IconButton(
                              icon: Icon(Iconsax.location_add, color: darkBlue),
                              onPressed: () async {
                                // Push to the LocationPicker and get result back
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LocationPicker()),
                                );

                                if (result != null) {
                                  setState(() {
                                    _location = result.toString();
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      // Photo Upload
                      Text(
                        'Upload Photos (Max 3)',
                        style: theme.textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          for (var image in _images)
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.file(image, height: 50, width: 50),
                            ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ]),
                            child: IconButton(
                              icon: Icon(Iconsax.camera, color: darkBlue),
                              onPressed: () async {
                                if (_images.length < 3) {
                                  final pickedFile = await _picker.pickImage(
                                      source: ImageSource.camera,
                                      imageQuality: 50);
                                  if (pickedFile != null) {
                                    setState(() {
                                      _images.add(File(pickedFile.path));
                                    });
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Max 3 images allowed")),
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ]),
                            child: IconButton(
                              icon: Icon(Iconsax.gallery_add, color: darkBlue),
                              onPressed: () async {
                                if (_images.length < 3) {
                                  final pickedFile = await _picker.pickImage(
                                      source: ImageSource.gallery,
                                      imageQuality: 50);
                                  if (pickedFile != null) {
                                    setState(() {
                                      _images.add(File(pickedFile.path));
                                    });
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Max 3 images allowed")),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                      // Pollution Severity Slider
                      Text(
                        'Pollution Severity',
                        style: theme.textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Slider(
                        value: _pollutionSeverity,
                        min: 1,
                        max: 3,
                        divisions: 2,
                        label: _getSeverityLabel(_pollutionSeverity),
                        activeColor: darkBlue,
                        onChanged: (val) {
                          setState(() {
                            _pollutionSeverity = val;
                          });
                        },
                      ),

                      SizedBox(height: 20),

                      // Submit Button
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // Show confirmation dialog
                              showAnimatedDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Confirmation'),
                                  content: Text(
                                      'Are you sure you want to submit the report?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        // Submit data
                                        await _submitReport();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Submit'),
                                    ),
                                  ],
                                ),
                                animationType: DialogTransitionType.scale,
                                curve: Curves.easeInOut,
                                duration: Duration(milliseconds: 300),
                              );
                            }
                          },
                          child: Text(
                            'Submit Report',
                            style: GoogleFonts.raleway(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitReport() async {
    // Handle the submission logic here
    // You can use Firebase or any other service to store the report
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Report submitted successfully')),
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

  LinearGradient get gradientbg => LinearGradient(
        colors: [lightblue, darkblue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  Color get backgroundBlue => Color(0xFF89CAE6);
  Color get textorange => Color(0xFFEE785E);
  Color get textblack => Color(0xFF000000);
  Color get darkBlue => Color(0xFF0B0672);
  Color get lightblue => Color(0xFF5EC4E6);
  Color get darkblue => Color(0xFF020469);
}
