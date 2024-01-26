// ignore_for_file: must_be_immutable

import 'package:firebase_learn/notes_app/features/bloc/notes_bloc.dart';
import 'package:firebase_learn/notes_app/features/model/notemodel.dart';
import 'package:firebase_learn/notes_app/constrain/colors.dart';
import 'package:firebase_learn/notes_app/features/screens/add_notes/addnote.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesViewScreen extends StatelessWidget {
  NotesViewScreen({
    super.key,
    required this.index,
    required this.docId,
    required this.disc,
    required this.title,
    required this.uId,
  });
  int index;
  String docId;
  String uId;
  String title;
  String disc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.shade100,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddNotesScreen(
                          disc: title,
                          title: disc,
                          index: index,
                          docId: docId,
                          isUpdate: true,
                          uId: uId),
                    ));
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                Navigator.pop(context);

                context
                    .read<NotesBloc>()
                    .add(NotesDeleteEvent(docId: docId, uId: uId));
              },
              icon: const Icon(Icons.delete))
        ],
        backgroundColor: UIColors.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              if (state is NotesLoadingState) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
              if (state is NotesErrorState) {
                return Center(child: Text(state.errMsg.toString()));
              }
              if (state is NotesLoadedState) {
                var blocData = state.data.docs;
                var mData = NoteModel.fromMap(blocData[index].data());
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mData.title.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      mData.discription.toString(),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: UIColors.black45),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
