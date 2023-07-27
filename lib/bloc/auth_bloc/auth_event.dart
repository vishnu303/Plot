part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInRequest extends AuthEvent {
  final String email;
  final String password;
  const SignInRequest({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
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

class GetUserDetails extends AuthEvent {
  const GetUserDetails();

  @override
  List<Object> get props => [];
}

class UpdateUserData extends AuthEvent {
  final String email;
  final String username;
  const UpdateUserData({required this.email, required this.username});

  @override
  List<Object> get props => [email, username];
}
