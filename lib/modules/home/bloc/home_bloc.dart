import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:programming_hacks/models/languages_model.dart';
import 'package:programming_hacks/repository/languages_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LanguagesRepository languagesRepository;
  HomeBloc({required this.languagesRepository}) : super(LanguagesLoadingState()) {
    on<GetLanguagesEvent>((event, emit) async {
      try {
        final response = await LanguagesRepository().getLanguages();
        emit(LanguagesLoadedState(languagesModel: response));
      } on SupabaseRealtimeError {
        emit(LanguagesErrorState());
      }
    });
  }
}
