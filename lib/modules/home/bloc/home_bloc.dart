import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:programming_hacks/models/languages_model.dart';
import 'package:programming_hacks/repository/languages_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetLanguagesEvent>((event, emit) async {
      try {
        emit(GetLanguagesState(isLoading: true));
        final response = await LanguagesRepository().getLanguages();
        emit(GetLanguagesState(isLoading: false, isCompleted: true, languagesModel: response));
      } on SupabaseRealtimeError {
        emit(GetLanguagesState(hasError: true));
      }
    });
  }
}
