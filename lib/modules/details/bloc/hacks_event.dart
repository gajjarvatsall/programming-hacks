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

class AddUserIdEvent extends HacksEvent {
  final String userId;
  final String documentId;
  AddUserIdEvent({required this.userId, required this.documentId});
}
