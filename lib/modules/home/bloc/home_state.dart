part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LanguagesLoadingState extends HomeState {
  List<Object?> get props => [];
}

class LanguagesLoadedState extends HomeState {
  LanguagesLoadedState({this.languagesModel});

  final List<LanguagesModel>? languagesModel;

  List<Object?> get props => [languagesModel];
}

class LanguagesErrorState extends HomeState {
  List<Object?> get props => [];
}

// class GetLanguagesState extends HomeState {
//   final bool isLoading;
//   final bool isCompleted;
//   final bool hasError;
//   final List<LanguagesModel>? languagesModel;
//   GetLanguagesState({
//     this.isLoading = false,
//     this.isCompleted = false,
//     this.hasError = false,
//     this.languagesModel,
//   });
// }
