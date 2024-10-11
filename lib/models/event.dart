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

final List<Event> events = [
  Event(
    title: 'Mirissa Beach Cleanup',
    description:
        'Join us in a beach cleanup at the beautiful Mirissa Beach, Sri Lanka, and help reduce plastic pollution along the coastline. Volunteers are needed to keep our oceans clean and safe.',
    image: 'assets/images/eventimg1.png',
    date: '2024-10-15',
    location: GeoPoint(
        5.9449, 80.3875), // Latitude and Longitude for Mirissa, Sri Lanka
  ),
  Event(
    title: 'Freedom Island Coastal Cleanup',
    description:
        'Freedom Island Beach in Manila, Philippines, is one of the most polluted beaches. Help us remove plastic waste and restore the natural beauty of this area.',
    image: 'assets/images/eventimg2.png',
    date: '2024-10-20',
    location: GeoPoint(
        14.5754, 120.9906), // Latitude and Longitude for Freedom Island, Manila
  ),
  Event(
    title: 'Colombo Harbor Marine Restoration',
    description:
        'Support the restoration of marine life at Colombo Harbor by participating in an underwater cleanup. Divers and snorkelers are welcome to help remove waste from the water.',
    image: 'assets/images/eventimg3.png',
    date: '2024-10-25',
    location: GeoPoint(
        6.9271, 79.8612), // Latitude and Longitude for Colombo, Sri Lanka
  ),
  Event(
    title: 'Bali Beach Conservation',
    description:
        'The famous beaches of Bali are facing increasing pollution challenges. Join our conservation team for a cleanup event and contribute to preserving this tropical paradise.',
    image: 'assets/images/eventimg4.png',
    date: '2024-11-01',
    location: GeoPoint(
        -8.4095, 115.1889), // Latitude and Longitude for Bali, Indonesia
  ),
  Event(
    title: 'Great Barrier Reef Restoration',
    description:
        'Join a unique event to help restore the Great Barrier Reef by removing debris and assisting in coral replanting efforts. This event is vital to the health of the world’s largest coral reef system.',
    image: 'assets/images/eventimg5.png',
    date: '2024-11-10',
    location: GeoPoint(-18.2871,
        147.6992), // Latitude and Longitude for Great Barrier Reef, Queensland, Australia
  ),
];
