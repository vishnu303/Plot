part of 'storage_bloc.dart';

abstract class StorageEvent extends Equatable {
  const StorageEvent();

  @override
  List<Object> get props => [];
}

class PickImage extends StorageEvent {
  final String childName;
  final File file;
  final bool isPost;
  const PickImage({
    required this.childName,
    required this.file,
    required this.isPost,
  });

  @override
  List<Object> get props => [];
}
