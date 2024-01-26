// ignore_for_file: collection_methods_unrelated_type

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learn/notes_app/features/model/notemodel.dart';
import 'package:flutter/material.dart';
part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  FirebaseFirestore firestore;
  var titleController = TextEditingController();
  var discController = TextEditingController();
  NotesBloc({required this.firestore}) : super(NotesInitial()) {
    on<NotesAddEvent>(notesAddEvent);
    on<NotesFetchEvent>(notesFetchEvent);
    on<NotesDeleteEvent>(notesDeleteEvent);
    on<NotesUpdateEvent>(notesUpdateEvent);
    on<UpdateTextFieldEvent>(updateTextFieldEvent);
  }

  FutureOr<void> notesFetchEvent(
      NotesFetchEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoadingState());
    emit(NotesLoadedState(
        data: await firestore
            .collection('user')
            .doc(event.uId)
            .collection('notes')
            .get()));
  }

  FutureOr<void> notesAddEvent(
      NotesAddEvent event, Emitter<NotesState> emit) async {
    if (titleController.text.isNotEmpty && discController.text.isNotEmpty) {
      emit(NotesLoadingState());
      try {
        var callRef = firestore.collection('user');
        if (titleController.text.isNotEmpty && discController.text.isNotEmpty) {
          await callRef.doc(event.uid).collection('notes').add(NoteModel(
                  discription: discController.text.toString(),
                  title: titleController.text.toString())
              .toMap());
          titleController.clear();
          discController.clear();
        }
        emit(NotesLoadedState(
            data: await firestore
                .collection('user')
                .doc(event.uid)
                .collection('notes')
                .get()));
      } catch (e) {
        emit(NotesErrorState(errMsg: e.toString()));
      }
    }
  }

  FutureOr<void> notesDeleteEvent(
      NotesDeleteEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoadingState());
    // firestore.collection('notes').doc(event.docId).delete();
    firestore
        .collection('user')
        .doc(event.uId)
        .collection('notes')
        .doc(event.docId)
        .delete();
    emit(NotesLoadedState(
        data: await firestore
            .collection('user')
            .doc(event.uId)
            .collection('notes')
            .get()));
  }

  FutureOr<void> notesUpdateEvent(
      NotesUpdateEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoadingState());
    try {
      firestore
          .collection('user')
          .doc(event.uId)
          .collection('notes')
          .doc(event.docId)
          .update(NoteModel(
                  discription: discController.text.toString(),
                  title: titleController.text.toString())
              .toMap());
      emit(NotesLoadedState(
          data: await firestore
              .collection('user')
              .doc(event.uId)
              .collection("notes")
              .get()));
      titleController.clear();
      discController.clear();
    } catch (e) {
      emit(NotesErrorState(errMsg: e.toString()));
    }
  }

  FutureOr<void> updateTextFieldEvent(
      UpdateTextFieldEvent event, Emitter<NotesState> emit) {
    titleController.text = event.title;
    discController.text = event.disc;
  }
}
