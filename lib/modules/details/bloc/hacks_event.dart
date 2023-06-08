part of 'hacks_bloc.dart';

@immutable
abstract class HacksEvent {}

class GetHacksEvent extends HacksEvent {
  final String id;

  GetHacksEvent({required this.id});
}

class ShareHacksEvent extends HacksEvent {
  final ScreenshotController controller;
  final Widget widget;

  ShareHacksEvent({required this.controller, required this.widget});
}

class SaveHacksEvent extends HacksEvent {
  final String hackId;
  final String techId;
  final String hack_details;

  SaveHacksEvent({required this.hackId, required this.techId, required this.hack_details});
}

class GetSavedHacksEvent extends HacksEvent {}

class UnSavedHackEvent extends HacksEvent {
  final String documentId;

  UnSavedHackEvent({required this.documentId});
}
