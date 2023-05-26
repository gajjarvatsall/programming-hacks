part of 'hacks_bloc.dart';

@immutable
abstract class HacksEvent {}

class GetHacksEvent extends HacksEvent {
  final String id;

  GetHacksEvent({required this.id});
}

class ShareHacksEvent extends HacksEvent {
  final ScreenshotController controller;

  ShareHacksEvent({required this.controller});
}
