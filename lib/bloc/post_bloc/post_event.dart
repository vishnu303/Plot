part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class UploadPostRequest extends PostEvent {
  final String username;
  final String userAvatarUrl;
  final String title;
  final String description;
  final String location;
  final String itemCategory;
  final int price;
  final String phoneNo;
  final List<File> images;
  const UploadPostRequest({
    required this.username,
    required this.userAvatarUrl,
    required this.title,
    required this.description,
    required this.location,
    required this.itemCategory,
    required this.phoneNo,
    required this.price,
    required this.images,
  });

  @override
  List<Object> get props => [
        username,
        userAvatarUrl,
        title,
        description,
        location,
        itemCategory,
        price,
        phoneNo,
        images,
      ];
}

class GetPosts extends PostEvent {}
