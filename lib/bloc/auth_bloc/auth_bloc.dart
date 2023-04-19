import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot/firebase_repo/auth_repo.dart';
import 'package:plot/model/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(const UnAuthenticated()) {
    on<SignUpRequest>((event, emit) async {
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

    on<SignInRequest>((event, emit) async {
      emit(const UnAuthenticated());
      try {
        await AuthRepository().signIn(
          email: event.email,
          password: event.password,
        );
      } catch (e) {
        emit(AuthenticationError(e.toString()));
      }
    });

    on<GetUserDetails>((event, emit) async {
      try {
        UserModel data = await authRepository.getUserdata();
        emit(Authenticated(userdata: data));
      } catch (e) {
        emit(AuthenticationError(e.toString()));
        throw (e.toString());
      }
    });
  }
}
