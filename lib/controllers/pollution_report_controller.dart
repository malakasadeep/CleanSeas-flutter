import 'package:clean_seas_flutter/models/pollution_report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class PollutionReportController {
  Future<bool> saveReport(PollutionReport report, List<File> images) async {
    try {
      // Ensure the user is authenticated
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('User is not authenticated');
        return false;
      }

      // Create a Firestore document
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('pollutionReports')
          .add(report.toMap());

      // Upload images to Firebase Storage and get download URLs
      List<String> imageUrls = [];
      for (File image in images) {
        String fileName = image.path.split('/').last;
        try {
          // Upload image
          TaskSnapshot uploadTask = await FirebaseStorage.instance
              .ref('reports/${docRef.id}/$fileName')
              .putFile(image);

          // Get download URL
          String downloadUrl = await uploadTask.ref.getDownloadURL();
          imageUrls.add(downloadUrl);
          print('Uploaded $fileName successfully and URL: $downloadUrl');
        } catch (uploadError) {
          print('Error uploading $fileName: $uploadError');
          // Optionally handle or continue with other files
        }
      }

      // Update the Firestore document with image URLs
      await docRef.update({'imageUrls': imageUrls});

      return true; // Indicate success
    } catch (e, stacktrace) {
      print('Error saving report: $e');
      print('Stacktrace: $stacktrace'); // Print stacktrace for more context
      return false; // Indicate failure
    }
  }
}
