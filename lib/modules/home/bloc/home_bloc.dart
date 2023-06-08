import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:programming_hacks/models/languages_model.dart';
import 'package:programming_hacks/repository/hacks_repo.dart';
import 'package:programming_hacks/repository/languages_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  LanguagesRepository languagesRepository = LanguagesRepository();

  HomeBloc({required this.languagesRepository}) : super(TechnologyLoadingState()) {
    on<GetTechnologyEvent>((event, emit) async {
      try {
        final response = await languagesRepository.getLanguages();
        emit(TechnologyLoadedState(technologyData: response));
      } catch (e) {
        print(e.toString());
        emit(TechnologyErrorState());
      }
    });
    on<CreateHacksEvent>((event, emit) async {
      try {
        emit(CreateHacksLoadingState());
        await HacksRepository().addHacks(event.techId, event.hackDetails);
        emit(CreateHacksLoadedState());
      } catch (e) {
        emit(CreateHacksErrorState());
      }
    });
  }
}
