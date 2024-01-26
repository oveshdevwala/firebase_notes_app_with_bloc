// ignore_for_file: must_be_immutable
import 'package:firebase_learn/notes_app/features/bloc/notes_bloc.dart';
import 'package:firebase_learn/notes_app/constrain/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNotesScreen extends StatelessWidget {
  AddNotesScreen(
      {super.key,
      required this.index,
      required this.docId,
      required this.uId,
      required this.title,
      required this.disc,
      required this.isUpdate});
  int index;
  String uId;
  String docId;
  bool isUpdate;
  String title;
  String disc;

  @override
  Widget build(BuildContext context) {
    if (isUpdate) {
      context
          .read<NotesBloc>()
          .add(UpdateTextFieldEvent(title: title, disc: disc));
    }
    return Scaffold(
      backgroundColor: UIColors.shade100,
      appBar: AppBar(
          backgroundColor: UIColors.shade100,
          actions: [
            TextButton(
                onPressed: () {
                  if (!isUpdate) {
                    context.read<NotesBloc>().add(NotesAddEvent(uid: uId));
                  } else {
                    context.read<NotesBloc>().add(
                        NotesUpdateEvent(docId: docId, uId: uId, index: index));
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  isUpdate ? 'Update' : 'Save',
                  style: TextStyle(color: UIColors.black),
                )),
            const SizedBox(
              width: 20,
            )
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.back,
                color: UIColors.black,
              ))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: context.read<NotesBloc>().titleController,
              minLines: 1,
              maxLines: 5,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: UIColors.black),
              decoration: const InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
            TextField(
              controller: context.read<NotesBloc>().discController,
              minLines: 5,
              maxLines: 100,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: UIColors.black),
              decoration: const InputDecoration(
                  hintText: 'Discription',
                  hintStyle: TextStyle(fontSize: 14),
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ],
        ),
      ),
    );
  }
}
