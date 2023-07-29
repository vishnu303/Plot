import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:plot/firebase_repo/storage_repo.dart';
import 'package:uuid/uuid.dart';

import '../model/post_model.dart';

class PostRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //upload post to firebase
  Future<void> uploadPost({
    required String title,
    String? description,
    required String location,
    required String username,
    required String userAvatarUrl,
    required int price,
    required String itemCategory,
    required String phoneNo,
    required List<File> images,
  }) async {
    try {
      List<String> imageUrls = await Future.wait(images.map((e) async {
        return await StorageRepo().uploadToStorage('posts', e, true);
      }).toList());

      debugPrint(imageUrls[0].toString());
      String postId = const Uuid().v1();
      String thumbnailUrl = imageUrls[0];

      Post post = Post(
        title: title,
        uid: _auth.currentUser!.uid,
        postId: postId,
        thumbnailUrl: thumbnailUrl,
        username: username,
        userAvatarUrl: userAvatarUrl,
        datePublished: DateTime.now(),
        price: price,
        description: description ?? '',
        location: location,
        phoneNo: phoneNo,
        imageUrls: imageUrls,
        itemCategory: itemCategory,
      );
      _firestore.collection('posts').doc(postId).set(post.toMap());
    } catch (e) {
      throw e.toString();
    }
  }

//get posts from firebase and convert to model
  Future<List<Post>> getPosts() async {
    try {
      QuerySnapshot posts = await _firestore.collection('posts').get();
      List<Post> data = posts.docs.map((DocumentSnapshot snap) {
        return Post.fromMap(snap);
      }).toList();

      return data;
    } on FirebaseException catch (e) {
      debugPrint(e.code);
      throw Exception(e.message);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

//get category from firebase
  Future<List<Post>> getCategoryItem({required String categoryQuery}) async {
    try {
      QuerySnapshot posts = await _firestore
          .collection('posts')
          .where('itemCategory', isEqualTo: categoryQuery)
          .get();
      List<Post> data = posts.docs.map((DocumentSnapshot snap) {
        return Post.fromMap(snap);
      }).toList();

      return data;
    } on FirebaseException catch (e) {
      debugPrint(e.code);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<List<Post>> getPostById() async {
    try {
      String uid = _auth.currentUser!.uid;
      QuerySnapshot posts = await _firestore
          .collection('posts')
          .where('uid', isEqualTo: uid)
          .get();
      List<Post> data = posts.docs.map((DocumentSnapshot snap) {
        return Post.fromMap(snap);
      }).toList();

      return data;
    } on FirebaseException catch (e) {
      debugPrint(e.code);
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> deletePostById(String id) async {
    await _firestore.collection('posts').doc(id).delete();
  }
}
