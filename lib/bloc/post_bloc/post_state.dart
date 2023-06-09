part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostUploaded extends PostState {}

class PostUploading extends PostState {}

class PostUploadError extends PostState {
  final String error;

  const PostUploadError({required this.error});
}

class PostLoaded extends PostState {
  final List<Post> post;
  const PostLoaded({required this.post});

  @override
  List<Object> get props => [post];
}

class PostLoading extends PostState {}

class PostError extends PostState {
  final String error;

  const PostError({required this.error});

  @override
  List<Object> get props => [error];
}
