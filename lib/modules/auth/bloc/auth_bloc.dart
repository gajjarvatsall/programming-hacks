import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programming_hacks/modules/auth/bloc/auth_state.dart';
import 'package:programming_hacks/modules/auth/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';

class AuthUserBloc extends Bloc<AuthUserEvent, AuthUserState> {
  AuthenticationRepository authRepo = AuthenticationRepository();

  AuthUserBloc({required this.authRepo}) : super(UserSignupLoadingState()) {
    on<UserSignUpEvent>((event, emit) async {
      try {
        final response = await authRepo.signUpWithEmailAndPassword(
            event.email, event.password, event.name ?? "");
        if (response == true) {
          emit(UserSignupLoadedState());
        }
      } on SupabaseRealtimeError catch (e) {
        emit(UserSignupErrorState(errorMsg: e.message.toString()));
      } on AuthException catch (e) {
        emit(UserSignupErrorState(errorMsg: e.message.toString()));
      }
    });
    on<UserLoginEvent>((event, emit) async {
      try {
        await authRepo.login(event.email, event.password);
        emit(UserSignupLoadedState());
      } on SupabaseRealtimeError catch (e) {
        emit(UserSignupErrorState(errorMsg: e.message.toString()));
      } on AuthException catch (e) {
        emit(UserSignupErrorState(errorMsg: e.message.toString()));
      }
    });
    on<UserLogoutEvent>((event, emit) async {
      try {
        await authRepo.logout();
        emit(UserSignupLoadedState());
      } on SupabaseRealtimeError catch (e) {
        emit(UserSignupErrorState(errorMsg: e.message.toString()));
      } on AuthException catch (e) {
        emit(UserSignupErrorState(errorMsg: e.message.toString()));
      }
    });
  }
}
