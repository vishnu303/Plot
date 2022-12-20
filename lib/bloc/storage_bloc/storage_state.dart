part of 'storage_bloc.dart';

@immutable
abstract class StorageState extends Equatable {}

class StorageInitial extends StorageState {
  @override
  List<Object?> get props => [];
}

class ImagePicked extends StorageState {
  final String photoUrl;
  ImagePicked({
    required this.photoUrl,
  });

  @override
  List<Object> get props => [photoUrl];
}

class Error extends StorageState {
  final String error;
  Error(this.error);

  @override
  List<Object> get props => [error];
}
