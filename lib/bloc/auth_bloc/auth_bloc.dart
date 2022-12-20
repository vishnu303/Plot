import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot/firebase_repo/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const UnAuthenticated()) {
    on<SignUpRequest>((event, emit) async {
      emit(const UnAuthenticated());
      try {
        await AuthRepository().signUp(
            username: event.username,
            password: event.password,
            email: event.email,
            image: event.image);
        emit(const Authenticated());
      } catch (e) {
        emit(AuthenticationError(e.toString()));
      }
    });
  }
}
