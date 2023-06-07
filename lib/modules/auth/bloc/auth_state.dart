import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:programming_hacks/models/users_model.dart';

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
  // final String? userName;

  // UserSignupLoadedState({this.userName});
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

// OAuth2Session state
class OAuth2SessionLoadingState extends AuthUserState {
  @override
  List<Object?> get props => [];
}

class OAuth2SessionLoadedState extends AuthUserState {
  @override
  List<Object?> get props => [];
}

class OAuth2SessionErrorState extends AuthUserState {
  final String errorMsg;

  OAuth2SessionErrorState({required this.errorMsg});

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

class GetUserLoadingState extends AuthUserState {
  @override
  List<Object?> get props => [];
}

class GetUserLoadedState extends AuthUserState {
  final List<UsersModel>? userData;

  GetUserLoadedState({this.userData});

  @override
  List<Object?> get props => [userData];
}

class GetUserErrorState extends AuthUserState {
  final String errorMsg;

  GetUserErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}
