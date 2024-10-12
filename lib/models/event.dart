import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String title;
  final String description;
  final String image;
  final String date;
  final GeoPoint location; // Use GeoPoint for location

  Event({
    required this.title,
    required this.description,
    required this.image,
    required this.date,
    required this.location, // Ensure location is provided as GeoPoint
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'image': image,
      'location':
          GeoPoint(location.latitude, location.longitude), // Map to GeoPoint
    };
  }
}
