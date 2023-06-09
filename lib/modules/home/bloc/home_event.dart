part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetTechnologyEvent extends HomeEvent {}

class CreateHacksEvent extends HomeEvent {
  String techId;
  String hackDetails;

  CreateHacksEvent({
    required this.techId,
    required this.hackDetails,
  });
}
