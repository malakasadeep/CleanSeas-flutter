import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:clean_seas_flutter/models/event.dart';

class EventController {
  Future<bool> saveEvent(Event event) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('User is not authenticated');
        return false;
      }

      await FirebaseFirestore.instance.collection('events').add(event.toMap());
      return true;
    } catch (e, stacktrace) {
      print('Error saving event: $e');
      print('Stacktrace: $stacktrace');
      return false;
    }
  }

  // Fetch events from Firestore
  Future<List<Event>> fetchEvents() async {
    List<Event> eventList = [];
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('events').get();

      for (var doc in snapshot.docs) {
        eventList.add(Event(
          title: doc['title'],
          description: doc['description'],
          image: doc['image'],
          date: doc['date'],
          location: doc['location'] is GeoPoint
              ? doc['location'] // Ensure this is a GeoPoint
              : GeoPoint(0, 0), // Default or error handling
        ));
      }
    } catch (e) {
      print('Error fetching events: $e');
    }
    return eventList;
  }
}
