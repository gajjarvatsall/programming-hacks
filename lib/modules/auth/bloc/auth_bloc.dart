import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programming_hacks/modules/auth/bloc/auth_state.dart';
import 'package:programming_hacks/modules/auth/repository/auth_repository.dart';

part 'auth_event.dart';

class AuthUserBloc extends Bloc<AuthUserEvent, AuthUserState> {
  AuthenticationRepository authRepo = AuthenticationRepository();

  AuthUserBloc({required this.authRepo}) : super(UserInitialState()) {
    on<UserSignUpEvent>((event, emit) async {
      try {
        emit(UserSignupLoadingState());
        final response = await authRepo.signUpWithEmailAndPassword(
          event.email,
          event.password,
          event.name ?? "",
        );
        if (response == true) {
          emit(UserSignupLoadedState());
        }
      } on AppwriteException catch (e) {
        emit(UserSignupErrorState(errorMsg: e.message.toString()));
      }
    });
    on<UserLoginEvent>((event, emit) async {
      try {
        emit(UserLoginLoadingState());
        await authRepo.login(event.email, event.password);
        emit(UserLoginLoadedState());
      } on AppwriteException catch (e) {
        emit(UserLoginErrorState(errorMsg: e.message.toString()));
      }
    });
    on<OAuth2SessionEvent>((event, emit) async {
      try {
        emit(OAuth2SessionLoadingState());
        await authRepo.oAuth2Session(event.provider);
        emit(OAuth2SessionLoadedState());
      } on AppwriteException catch (e) {
        emit(OAuth2SessionErrorState(errorMsg: e.message.toString()));
      }
    });
    on<UserLogoutEvent>((event, emit) async {
      try {
        emit(UserLogoutLoadingState());
        await authRepo.logout();
        emit(UserLogoutLoadedState());
      } catch (e) {
        emit(UserLoginErrorState(errorMsg: e.toString()));
      }
    });
  }
}
