import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PollutionCard extends StatelessWidget {
  final String imageUrl;
  final String pollutionType;
  final double pollutionSeverity;
  final String reporterName;
  final DateTime incidentDate;
  final VoidCallback onTap;

  PollutionCard({
    required this.imageUrl,
    required this.pollutionType,
    required this.pollutionSeverity,
    required this.reporterName,
    required this.incidentDate,
    required this.onTap,
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 5,
        color: Color.fromARGB(255, 229, 229, 229), // Card background color
        child: Padding(
          padding: const EdgeInsets.all(12.0), // Padding inside the card
          child: Row(
            children: [
              // Display pollution image
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrl,
                  height: 100, // Adjust height as needed
                  width: 100, // Adjust width as needed
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12), // Space between image and text
              Expanded(
                // Ensures text takes remaining space
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$pollutionType Pollution",
                      style: GoogleFonts.raleway(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Severity: ${_getSeverityLabel(pollutionSeverity)}',
                      style: TextStyle(
                        color: _getSeverityColor(pollutionSeverity),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('Reported by: $reporterName'),
                    SizedBox(height: 5),
                    Text(
                      'Date: ${DateFormat('yyyy-MM-dd').format(incidentDate)}',
                    ),
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
