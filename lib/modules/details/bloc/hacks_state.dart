part of 'hacks_bloc.dart';

@immutable
abstract class HacksState extends Equatable {}

class HacksLoadingState extends HacksState {
  @override
  List<Object?> get props => [];
}

class HacksLoadedState extends HacksState {
  HacksLoadedState({this.hacksModel});

  final List<HacksModel>? hacksModel;

  @override
  List<Object?> get props => [hacksModel];
}

class HacksErrorState extends HacksState {
  @override
  List<Object?> get props => [];
}

class SaveHacksLoadedState extends HacksState {
  @override
  List<Object?> get props => [];
}

class SaveHackLoadingState extends HacksState {
  @override
  List<Object?> get props => [];
}

class SaveHacksErrorState extends HacksState {
  @override
  List<Object?> get props => [];
}

class GetSavedHackLoadingState extends HacksState {
  @override
  List<Object?> get props => [];
}

class GetSavedHackLoadedState extends HacksState {
  GetSavedHackLoadedState({required this.savedData});

  final Set<String> savedData;

  @override
  List<Object?> get props => [savedData];
}

class GetSavedHackErrorState extends HacksState {
  @override
  List<Object?> get props => [];
}

class UnSavedHackLoadingState extends HacksState {
  @override
  List<Object?> get props => [];
}

class UnSavedHackLoadedState extends HacksState {
  @override
  List<Object?> get props => [];
}

class UnSavedHackErrorState extends HacksState {
  @override
  List<Object?> get props => [];
}
