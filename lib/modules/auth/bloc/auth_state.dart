import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthUserState extends Equatable {}

// Sign UP state
class UserInitialState extends AuthUserState {
  @override
  List<Object?> get props => [];
}

class UserSignupLoadingState extends AuthUserState {
  @override
  List<Object?> get props => [];
}

class UserSignupLoadedState extends AuthUserState {
  @override
  List<Object?> get props => [];
}

class UserSignupErrorState extends AuthUserState {
  final String errorMsg;

  UserSignupErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

// Login State
class UserLoginLoadingState extends AuthUserState {
  @override
  List<Object?> get props => [];
}

class UserLoginLoadedState extends AuthUserState {
  @override
  List<Object?> get props => [];
}

class UserLoginErrorState extends AuthUserState {
  final String errorMsg;

  UserLoginErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

// Logout State
class UserLogoutLoadingState extends AuthUserState {
  @override
  List<Object?> get props => [];
}

class UserLogoutLoadedState extends AuthUserState {
  @override
  List<Object?> get props => [];
}

class UserLogoutErrorState extends AuthUserState {
  final String errorMsg;

  UserLogoutErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}
