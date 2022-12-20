import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plot/firebase_repo/storage_repo.dart';

import '../model/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp({
    required String username,
    required String password,
    required String email,
    required File image,
  }) async {
    try {
      if (username.isNotEmpty || password.isNotEmpty || email.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl =
            await StorageRepo().uploadToStorage('profilePicture', image, false);

        UserModel userData = UserModel(
          username: username,
          email: email,
          uid: cred.user!.uid,
          phtoUrl: photoUrl,
        );

        //uploading to firestore database
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(userData.toMap());
      }
    } catch (e) {
      throw e.toString();
    }
  }
}