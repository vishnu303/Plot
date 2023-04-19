import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot/firebase_repo/post_repo.dart';

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
  }
}
