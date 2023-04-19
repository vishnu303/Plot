import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String username;
  final String email;
  final String uid;
  final String photoUrl;
  UserModel({
    required this.username,
    required this.email,
    required this.uid,
    required this.photoUrl,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? uid,
    String? photoUrl,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'uid': uid,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromMap(DocumentSnapshot snap) {
    var map = snap.data() as Map<String, dynamic>;

    return UserModel(
      username: map['username'] as String,
      email: map['email'] as String,
      uid: map['uid'] as String,
      photoUrl: map['photoUrl'] as String,
    );
  }
}
