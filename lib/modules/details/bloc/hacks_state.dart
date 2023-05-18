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
