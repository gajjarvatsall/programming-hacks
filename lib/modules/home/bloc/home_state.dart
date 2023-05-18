part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetLanguagesState extends HomeState {
  final bool isLoading;
  final bool isCompleted;
  final bool hasError;
  final List<LanguagesModel>? languagesModel;
  GetLanguagesState({
    this.isLoading = false,
    this.isCompleted = false,
    this.hasError = false,
    this.languagesModel,
  });
}
