import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class StorageRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadToStorage(
    String childName,
    File file,
    bool isPost,
  ) async {
    try {
      //creating location to upload image
      Reference ref =
          _storage.ref().child(childName).child(_auth.currentUser!.uid);

      UploadTask uploadTask = ref.putFile(file);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }
}
