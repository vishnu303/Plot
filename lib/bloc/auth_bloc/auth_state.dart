part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final UserModel? userdata;
  const Authenticated({this.userdata});

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
  List<Object> get props => [error];
}

// class UserDetails extends AuthState {
//   final UserModel userdata;
//   const UserDetails({required this.userdata});
// }
class UserUpdated extends AuthState {
  @override
  List<Object> get props => [];
}

class UserUpdateError extends AuthState {
  final String error;
  const UserUpdateError({required this.error});
  @override
  List<Object> get props => [error];
}

class UserUpdating extends AuthState {
  const UserUpdating();
}

class AccountDeleting extends AuthState {
  const AccountDeleting();
}

class AccountDeleted extends AuthState {
  const AccountDeleted();
}

class DeleteError extends AuthState {
  final String error;
  const DeleteError({required this.error});
  @override
  List<Object> get props => [error];
}

class ReAuthenticated extends AuthState {
  const ReAuthenticated();
}

class ReAuthenticating extends AuthState {
  const ReAuthenticating();
}

class ReAuthenticationError extends AuthState {
  final String error;
  const ReAuthenticationError({required this.error});
  @override
  List<Object> get props => [error];
}
