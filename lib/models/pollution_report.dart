import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PollutionReport {
  final String location;
  final String pollutionType;
  final double pollutionSeverity;
  final String description;
  final String reporterName;
  final String contactInfo;
  final DateTime incidentDate;
  final TimeOfDay? incidentTime;
  final String city;

  final List<String>? imageUrls; // New field for storing image URLs

  PollutionReport({
    required this.location,
    required this.pollutionType,
    required this.pollutionSeverity,
    required this.description,
    required this.reporterName,
    required this.contactInfo,
    required this.incidentDate,
    this.incidentTime,
    required this.city,
    this.imageUrls, // Initialize the new field in the constructor
  });

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'pollutionType': pollutionType,
      'pollutionSeverity': pollutionSeverity,
      'description': description,
      'reporterName': reporterName,
      'contactInfo': contactInfo,
      'incidentDate': incidentDate.toIso8601String(),
      'incidentTime': incidentTime != null
          ? '${incidentTime!.hour}:${incidentTime!.minute}'
          : null, // Store time as a string in "HH:mm" format
      'city': city,
      'imageUrls': imageUrls, // Add image URLs to the map
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
