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

class SaveHacksEvent extends HacksEvent {
  final String hackId;

  SaveHacksEvent({required this.hackId});
}

class GetSavedHacksEvent extends HacksEvent {}

class UnSavedHackEvent extends HacksEvent {
  final String documentId;

  UnSavedHackEvent({required this.documentId});
}
