import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      } on FirebaseAuthException catch (e) {
        String error = '';
        emit(const UnAuthenticated());

        switch (e.code) {
          case "ERROR_EMAIL_ALREADY_IN_USE":
          case "account-exists-with-different-credential":
          case "email-already-in-use":
            error = "Email already used. Go to login page.";
            break;
          case "ERROR_WRONG_PASSWORD":
          case "wrong-password":
            error = "Wrong email/password combination.";
            break;
          case "ERROR_USER_NOT_FOUND":
          case "user-not-found":
            error = "No user found with this email.";
            break;
          case "ERROR_USER_DISABLED":
          case "user-disabled":
            error = "User disabled.";
            break;
          case "ERROR_TOO_MANY_REQUESTS":
            error = "Too many requests to log into this account.";
            break;
          case "ERROR_OPERATION_NOT_ALLOWED":
          case "operation-not-allowed":
            error = "Server error, please try again later.";
            break;
          case "ERROR_INVALID_EMAIL":
          case "invalid-email":
            error = "Email address is invalid.";
            break;
          default:
            error = "Sign up failed. Please try again.";
            break;
        }

        emit(AuthenticationError(error));
      }
    });

    on<SignInRequest>((event, emit) async {
      emit(const UnAuthenticated());
      try {
        await AuthRepository().signIn(
          email: event.email,
          password: event.password,
        );
      } on FirebaseAuthException catch (e) {
        String error = '';
        emit(const UnAuthenticated());
        print(e.code);

        switch (e.code) {
          case "ERROR_EMAIL_ALREADY_IN_USE":
          case "account-exists-with-different-credential":
          case "email-already-in-use":
            error = "Email already used. Go to login page.";
            break;
          case "ERROR_WRONG_PASSWORD":
          case "wrong-password":
            error = "Wrong email or password.";
            break;
          case "ERROR_USER_NOT_FOUND":
          case "user-not-found":
            error = "No user found with this email.";
            break;
          case "ERROR_USER_DISABLED":
          case "user-disabled":
            error = "User disabled.";
            break;
          case "ERROR_TOO_MANY_REQUESTS":
            error = "Too many requests to log into this account.";
            break;
          case "ERROR_OPERATION_NOT_ALLOWED":
          case "operation-not-allowed":
            error = "Server error, please try again later.";
            break;
          case "ERROR_INVALID_EMAIL":
          case "invalid-email":
            error = "Email address is invalid.";
            break;
          default:
            error = "Login failed. Please try again.";
            break;
        }

        emit(AuthenticationError(error));
      }
    });

    on<GetUserDetails>((event, emit) async {
      try {
        UserModel data = await authRepository.getUserdata();
        emit(Authenticated(userdata: data));
      } catch (e) {
        debugPrint(e.toString());
        emit(AuthenticationError(e.toString()));
      }
    });
  }
}
