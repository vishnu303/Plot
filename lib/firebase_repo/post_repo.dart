import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plot/firebase_repo/storage_repo.dart';
import 'package:uuid/uuid.dart';

import '../model/post_model.dart';

class PostRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //upload post to firebase
  void uploadPost({
    required String title,
    String? description,
    required String location,
    required String username,
    required String price,
    required String phoneNo,
    required String thumbnailUrl,
    required List<File> images,
  }) async {
    try {
      List<String> imageUrls = await Future.wait(images.map((e) async {
        return StorageRepo().uploadToStorage('posts', e, true).toString();
      }));
      String postId = const Uuid().v1();

      Post post = Post(
        title: title,
        uid: _auth.currentUser!.uid,
        postId: postId,
        thumbnailUrl: thumbnailUrl,
        username: username,
        datePublished: DateTime.now(),
        price: price,
        description: description ?? '',
        location: location,
        phoneNo: phoneNo,
        imageUrls: imageUrls,
      );
      _firestore.collection('posts').doc(postId).set(post.toMap());
    } catch (e) {
      throw e.toString();
    }
  }
}
