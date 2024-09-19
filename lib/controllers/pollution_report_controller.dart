import 'dart:io';

import 'package:clean_seas_flutter/models/pollution_report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';

class PollutionReportController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> submitReport(PollutionReport report) async {
    try {
      await _firestore.collection('pollution_reports').add(report.toJson());
    } catch (e) {
      throw Exception('Failed to submit report: $e');
    }
  }

  Future<String> uploadImage(String imagePath) async {
    final storageRef = FirebaseStorage.instance.ref();
    final fileRef = storageRef.child('images/${DateTime.now()}.png');

    UploadTask uploadTask = fileRef.putFile(File(imagePath));
    final snapshot = await uploadTask.whenComplete(() => {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
