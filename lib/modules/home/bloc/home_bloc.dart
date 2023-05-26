import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:programming_hacks/models/languages_model.dart';
import 'package:programming_hacks/repository/languages_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  LanguagesRepository languagesRepository = LanguagesRepository();

  HomeBloc({required this.languagesRepository}) : super(LanguagesLoadingState()) {
    on<GetLanguagesEvent>((event, emit) async {
      try {
        final response = await languagesRepository.getLanguages();
        emit(LanguagesLoadedState(languagesModel: response));
      } catch (e) {
        print(e.toString());
        emit(LanguagesErrorState());
      }
    });
  }
}
