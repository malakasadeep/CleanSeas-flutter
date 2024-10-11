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

  final String normalizedCity; // New field for normalized city
  final List<String>? imageUrls; // Field for storing image URLs

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
    this.imageUrls, // Initialize the image URLs field in the constructor
  }) : normalizedCity =
            city.toLowerCase(); // Automatically assign normalized city

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
      'normalizedCity': normalizedCity, // Add normalized city to the map
      'imageUrls': imageUrls, // Add image URLs to the map
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
