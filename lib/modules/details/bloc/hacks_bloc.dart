import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:programming_hacks/models/hacks_model.dart';
import 'package:programming_hacks/repository/hacks_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'hacks_event.dart';
part 'hacks_state.dart';

class HacksBloc extends Bloc<HacksEvent, HacksState> {
  HacksBloc() : super(GetHacksState()) {
    on<GetHacksEvent>((event, emit) async {
      try {
        emit(GetHacksState(isLoading: true));
        final response = await HacksRepository().getHacks();
        emit(GetHacksState(isLoading: false, isCompleted: true, hacksModel: response));
      } on SupabaseRealtimeError {
        emit(GetHacksState(hasError: true));
      }
    });
  }
}
