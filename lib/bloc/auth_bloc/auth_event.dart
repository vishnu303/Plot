part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInRequest extends AuthState {
  const SignInRequest();

  @override
  List<Object> get props => [];
}

class SignUpRequest extends AuthEvent {
  final String username;
  final String password;
  final String email;
  final File image;
  const SignUpRequest(
      {required this.email,
      required this.password,
      required this.username,
      required this.image});

  @override
  List<Object> get props => [
        username,
        email,
        password,
        image,
      ];
}
