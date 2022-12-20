import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String username;
  final String email;
  final String uid;
  final String phtoUrl;
  UserModel({
    required this.username,
    required this.email,
    required this.uid,
    required this.phtoUrl,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? uid,
    String? password,
    String? phtoUrl,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      phtoUrl: phtoUrl ?? this.phtoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'uid': uid,
      'phtoUrl': phtoUrl,
    };
  }

  factory UserModel.fromMap(DocumentSnapshot snap) {
    var map = snap.data() as Map<String, dynamic>;

    return UserModel(
      username: map['username'] as String,
      email: map['email'] as String,
      uid: map['uid'] as String,
      phtoUrl: map['phtoUrl'] as String,
    );
  }
}
