import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot/firebase_repo/post_repo.dart';
import 'package:plot/model/post_model.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<UploadPostRequest>((event, emit) async {
      await PostRepository().uploadPost(
        title: event.title,
        location: event.location,
        description: event.description,
        username: event.username,
        userAvatarUrl: event.userAvatarUrl,
        price: event.price,
        itemCategory: event.itemCategory,
        phoneNo: event.phoneNo,
        images: event.images,
      );
    });

    //get all posts
    on<GetPosts>((event, emit) async {
      try {
        emit(PostLoading());
        List<Post> posts = await PostRepository().getPosts();
        emit(PostLoaded(post: posts));
        // debugPrint(posts[0].title);
      } on FirebaseException catch (e) {
        emit(PostError(error: e.code.toString()));
      }
    });

    on<GetMyPosts>((event, emit) async {
      try {
        emit(PostLoading());

        List<Post> posts = await PostRepository().getPostById();
        emit(PostLoaded(post: posts));
        debugPrint(posts[0].title);
      } on FirebaseException catch (e) {
        emit(PostError(error: e.code.toString()));
      }
    });
  }
}
