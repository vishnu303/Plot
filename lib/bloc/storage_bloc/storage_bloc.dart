import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot/firebase_repo/storage_repo.dart';

part 'storage_event.dart';
part 'storage_state.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  final StorageRepo storageRepo;
  StorageBloc({required this.storageRepo}) : super(StorageInitial()) {
    on<PickImage>((event, emit) async {
      emit(StorageInitial());

      try {
        String photoUrl = await StorageRepo()
            .uploadToStorage(event.childName, event.file, event.isPost);
        print(photoUrl);
        emit(ImagePicked(photoUrl: photoUrl));
      } catch (e) {
        emit(Error(e.toString()));
      }
    });
  }
}
