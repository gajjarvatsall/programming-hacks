import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:programming_hacks/models/hacks_model.dart';
import 'package:programming_hacks/repository/hacks_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'hacks_event.dart';
part 'hacks_state.dart';

class HacksBloc extends Bloc<HacksEvent, HacksState> {
  final HacksRepository hacksRepository;

  HacksBloc({required this.hacksRepository}) : super(HacksLoadingState()) {
    on<GetHacksEvent>((event, emit) async {
      try {
        final response = await hacksRepository.getHacks(event.id);
        emit(HacksLoadedState(hacksModel: response));
      } on SupabaseRealtimeError {
        emit(HacksErrorState());
      }
    });
  }
}
