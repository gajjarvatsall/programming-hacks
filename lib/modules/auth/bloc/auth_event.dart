part of 'auth_bloc.dart';

@immutable
abstract class AuthUserEvent {}

class UserSignUpEvent extends AuthUserEvent {
  final String? name;
  final String email;
  final String password;

  UserSignUpEvent({this.name, required this.email, required this.password});

  List<Object?> get pros => throw UnimplementedError();
}

class UserLoginEvent extends AuthUserEvent {
  final String email;
  final String password;

  UserLoginEvent({required this.email, required this.password});

  List<Object?> get pros => throw UnimplementedError();
}

class UserLogoutEvent extends AuthUserEvent {}
