part of 'hacks_bloc.dart';

@immutable
abstract class HacksState {}

class HacksInitial extends HacksState {}

class GetHacksState extends HacksState {
  final bool isLoading;
  final bool isCompleted;
  final bool hasError;
  final List<HacksModel>? hacksModel;
  GetHacksState({
    this.isLoading = false,
    this.isCompleted = false,
    this.hasError = false,
    this.hacksModel,
  });
}
