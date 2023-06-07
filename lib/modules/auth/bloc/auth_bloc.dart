import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programming_hacks/modules/auth/bloc/auth_state.dart';
import 'package:programming_hacks/modules/auth/repository/auth_repository.dart';
import 'package:programming_hacks/repository/user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';

class AuthUserBloc extends Bloc<AuthUserEvent, AuthUserState> {
  AuthenticationRepository authRepo = AuthenticationRepository();

  AuthUserBloc({required this.authRepo}) : super(UserInitialState()) {
    on<UserSignUpEvent>((event, emit) async {
      try {
        emit(UserSignupLoadingState());
        final response = await authRepo.signUpWithEmailAndPassword(
          event.name,
          event.email,
          event.password,
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("currentUser", event.name);
        prefs.setBool("isLoggedIn", true);

        emit(UserSignupLoadedState());
        if (response.status) {}
      } on AppwriteException catch (e) {
        emit(UserSignupErrorState(errorMsg: e.message.toString()));
      }
    });
    on<UserLoginEvent>((event, emit) async {
      try {
        emit(UserLoginLoadingState());
        await authRepo.login(event.email, event.password);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", true);
        emit(UserLoginLoadedState());
      } on AppwriteException catch (e) {
        emit(UserLoginErrorState(errorMsg: e.message.toString()));
      }
    });
    on<OAuth2SessionEvent>((event, emit) async {
      try {
        emit(OAuth2SessionLoadingState());
        User user = await authRepo.oAuth2Session(event.provider);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("currentUser", user.name);
        prefs.setBool("isLoggedIn", true);
        emit(OAuth2SessionLoadedState());
      } on AppwriteException catch (e) {
        emit(OAuth2SessionErrorState(errorMsg: e.message.toString()));
      }
    });

    on<GetUserEvent>((event, emit) async {
      try {
        emit(GetUserLoadingState());
        final response = await UsersRepository().getUsers();
        emit(GetUserLoadedState(userData: response));
      } on AppwriteException catch (e) {
        emit(GetUserErrorState(errorMsg: e.message.toString()));
      }
    });

    on<UserLogoutEvent>((event, emit) async {
      try {
        emit(UserLogoutLoadingState());
        await authRepo.logout();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        emit(UserLogoutLoadedState());
      } catch (e) {
        emit(UserLogoutErrorState(errorMsg: e.toString()));
      }
    });
  }
}
