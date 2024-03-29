import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:plot/firebase_repo/post_repo.dart';

import 'package:plot/firebase_repo/storage_repo.dart';
import 'package:plot/model/post_model.dart';

import '../model/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign up
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
          photoUrl: photoUrl,
        );

        //uploading to firestore database
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(userData.toMap());
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('from repo !!!!!!!!!!!1 ${e.code}');
      rethrow;
    }
  }

// sign in
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

// get user data
  Future<UserModel> getUserdata() async {
    User currentUser = _auth.currentUser!;
    UserModel? data;
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(currentUser.uid).get();

      data = UserModel.fromMap(documentSnapshot);
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

//update user data
  Future<void> updateUserdata(String? email, String? username) async {
    UserModel userdata = await getUserdata();
    User currentUser = _auth.currentUser!;
    if (_auth.currentUser!.email != email?.trim()) {
      try {
        await _auth.currentUser!.updateEmail(email!);
        await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .update({'email': email});
      } on FirebaseAuthException {
        rethrow;
      }
    }
    if (userdata.username != username?.trim()) {
      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .update({'username': username});
    }
  }

//delete account
  Future<void> deleteAccount() async {
    var currentUser = _auth.currentUser!;
    List<String> postId = [];

    List<Post> posts = await PostRepository().getPostById();
    for (var element in posts) {
      postId.add(element.postId);
    }

    await currentUser.delete();

    await _firestore.collection('users').doc(currentUser.uid).delete();

    for (var id in postId) {
      PostRepository().deletePostById(id);
    }
  }

//logout
  Future<void> logOut() async {
    await _auth.signOut();
  }

//Re-authenticate
  Future<void> reAuth(String password) async {
    try {
      var currentUser = _auth.currentUser!;

      AuthCredential credential = EmailAuthProvider.credential(
          email: currentUser.email!, password: password);
      await currentUser.reauthenticateWithCredential(credential);
    } on FirebaseAuthException {
      rethrow;
    }
  }

//change password
  Future<void> changePassword(String newPassword) async {
    try {
      var currentUser = _auth.currentUser!;
      await currentUser.updatePassword(newPassword);
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
