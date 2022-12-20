part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  const Authenticated();

  @override
  List<Object> get props => [];
}

class UnAuthenticated extends AuthState {
  const UnAuthenticated();

  @override
  List<Object> get props => [];
}

class AuthenticationError extends AuthState {
  final String error;
  const AuthenticationError(this.error);

  @override
  List<Object> get props => [];
}
