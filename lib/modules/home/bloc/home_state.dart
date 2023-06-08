part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class TechnologyLoadingState extends HomeState {
  List<Object?> get props => [];
}

class TechnologyLoadedState extends HomeState {
  TechnologyLoadedState({this.technologyData});

  final List<TechnologyModel>? technologyData;

  List<Object?> get props => [technologyData];
}

class TechnologyErrorState extends HomeState {
  List<Object?> get props => [];
}

class CreateHacksLoadingState extends HomeState {
  List<Object?> get props => [];
}

class CreateHacksLoadedState extends HomeState {
  List<Object?> get props => [];
}

class CreateHacksErrorState extends HomeState {
  List<Object?> get props => [];
}
