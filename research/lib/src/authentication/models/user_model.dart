import 'package:flutter/foundation.dart';

class UserModel {
  UserModel({
    @required this.uid,
    @required this.email,
  });

  final String uid;
  final String email;

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(uid: documentId, email: data['email'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {'email': email};
  }
}
