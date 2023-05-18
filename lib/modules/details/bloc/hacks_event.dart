part of 'hacks_bloc.dart';

@immutable
abstract class HacksEvent {}

class GetHacksEvent extends HacksEvent {
  final int id;

  GetHacksEvent({required this.id});
}
