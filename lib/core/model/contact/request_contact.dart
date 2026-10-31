import 'package:cloud_firestore/cloud_firestore.dart';

class RequestContact {
  final String? userUid;
  final String? fullName;
  final String? email;
  final String? subject;
  final String? message;

  RequestContact({
    required this.userUid,
    required this.fullName,
    required this.email,
    required this.subject,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'userUid': userUid,
      'fullName': fullName,
      'email': email,
      'subject': subject,
      'message': message,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
