// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'notes_bloc.dart';

@immutable
sealed class NotesState {}

final class NotesInitial extends NotesState {}

class NotesLoadingState extends NotesState {}

class NotesLoadedState extends NotesState {
  // FirebaseFirestore data;
  QuerySnapshot<Map<String, dynamic>> data;
  NotesLoadedState({
    required this.data,
  });
}

class NotesErrorState extends NotesState {
  String errMsg;
  NotesErrorState({
    required this.errMsg,
  });
}
