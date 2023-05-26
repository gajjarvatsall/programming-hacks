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
