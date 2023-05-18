import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programming_hacks/modules/auth/bloc/auth_state.dart';
import 'package:programming_hacks/modules/auth/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';

class AuthUserBloc extends Bloc<AuthUserEvent, AuthUserState> {
  AuthenticationRepository authRepo = AuthenticationRepository();

  AuthUserBloc({required this.authRepo}) : super(UserInitialState()) {
    on<UserSignUpEvent>((event, emit) async {
      try {
        final response = await authRepo.signUpWithEmailAndPassword(
            event.email, event.password, event.name ?? "");
        if (response == true) {
          emit(UserSignupLoadedState());
        }
      } on AuthException catch (e) {
        emit(UserSignupErrorState(errorMsg: e.message.toString()));
      }
      //  on SupabaseRealtimeError catch (e) {
      //   emit(UserSignupErrorState(errorMsg: e.message.toString()));
      // } on AuthException catch (e) {
      //   emit(UserSignupErrorState(errorMsg: e.message.toString()));
      // }
    });
    on<UserLoginEvent>((event, emit) async {
      try {
        emit(UserLoginLoadingState());
        await authRepo.login(event.email, event.password);
        emit(UserLoginLoadedState());
      } on SupabaseRealtimeError catch (e) {
        emit(UserLoginErrorState(errorMsg: e.message.toString()));
      } on AuthException catch (e) {
        emit(UserLoginErrorState(errorMsg: e.message.toString()));
      }
      // on SupabaseRealtimeError catch (e) {
      // } on AuthException catch (e) {
      //   emit(UserSignupErrorState(errorMsg: e.message.toString()));
      // }
    });
    on<UserLogoutEvent>((event, emit) async {
      try {
        emit(UserLogoutLoadingState());
        await authRepo.logout();
        emit(UserLogoutLoadedState());
      } on AuthException catch (e) {
        emit(UserLogoutErrorState(errorMsg: e.message.toString()));
      }
      // on SupabaseRealtimeError catch (e) {
      //   emit(UserSignupErrorState(errorMsg: e.message.toString()));
      // } on AuthException catch (e) {
      //   emit(UserSignupErrorState(errorMsg: e.message.toString()));
      // }
    });
  }
}
