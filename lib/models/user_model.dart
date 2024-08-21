import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String fullName; // For regular users
  final String ngoName; // For NGO users
  final String registrationNo; // For NGO users
  final String email;
  final String password;
  final String userType;

  UserModel({
    this.fullName = '',
    this.ngoName = '',
    this.registrationNo = '',
    required this.email,
    required this.password,
    required this.userType,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'ngoName': ngoName,
      'registrationNo': registrationNo,
      'email': email,
      'userType': userType,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  // Create a UserModel object from a Map object
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'] ?? '',
      ngoName: map['ngoName'] ?? '',
      registrationNo: map['registrationNo'] ?? '',
      email: map['email'] ?? '',
      password: '', // Password is usually not stored or retrieved in this way
      userType: map['userType'] ?? '',
    );
  }
}
