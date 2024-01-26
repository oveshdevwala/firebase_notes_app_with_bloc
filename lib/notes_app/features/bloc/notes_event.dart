// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent {}

class NotesAddEvent extends NotesEvent {
  String uid;
  NotesAddEvent({
    required this.uid,
  });
}

class NotesFetchEvent extends NotesEvent {
  String uId;
  NotesFetchEvent({
    required this.uId,
  });
}

class NotesDeleteEvent extends NotesEvent {
  String docId;
  String uId;
  NotesDeleteEvent({
    required this.docId,
    required this.uId,
  });
}

class NotesUpdateEvent extends NotesEvent {
  String docId;
  int index;
  String uId;
  NotesUpdateEvent({
    required this.docId,
    required this.index,
    required this.uId,
  });
}
class UpdateTextFieldEvent extends NotesEvent {
String title;
String disc;
  UpdateTextFieldEvent({
    required this.title,
    required this.disc,
  });
}
