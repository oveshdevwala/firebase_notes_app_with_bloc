// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learn/notes_app/features/bloc/notes_bloc.dart';
import 'package:firebase_learn/notes_app/features/model/notemodel.dart';
import 'package:firebase_learn/notes_app/features/screens/add_notes/addnote.dart';
import 'package:firebase_learn/notes_app/features/screens/notes_view/noteview.dart';
import 'package:flutter/material.dart';

// ListViewNotes(blocData: blocData, blocPath: blocPath, uID: uID, firestore: firestore)
class ListViewNotes extends StatelessWidget {
  const ListViewNotes({
    super.key,
    required this.blocData,
    required this.blocPath,
    required this.uID,
    required this.firestore,
  });

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> blocData;
  final NotesBloc blocPath;
  final String uID;
  final FirebaseFirestore firestore;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: blocData.length,
      itemBuilder: (context, index) {
        var docId = blocData[index].id;
        var mData = NoteModel.fromMap(blocData[index].data());
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onLongPress: () {
                blocPath.add(NotesDeleteEvent(docId: docId, uId: uID));
              },
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return NotesViewScreen(
                      docId: docId,
                      uId: uID,
                      index: index,
                      disc: mData.title,
                      title: mData.discription,
                    );
                  },
                ));
              },
              tileColor: Colors.green.shade200,
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return AddNotesScreen(
                          disc: mData.title,
                          title: mData.discription,
                          uId: uID,
                          index: index,
                          docId: docId,
                          isUpdate: true,
                        );
                      },
                    ));
                  },
                  icon: const Icon(Icons.edit)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: Text(mData.title),
              subtitle: Text(mData.discription),
            ));
      },
    );
  }
}

class NotesListViewLoadingState extends StatelessWidget {
  const NotesListViewLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text(''),
              subtitle: const Text(''),
              tileColor: Colors.green.shade200,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ));
      },
    );
  }
}

class NotesListViewErrorState extends StatelessWidget {
  NotesListViewErrorState({super.key, required this.errorMsg});
  String errorMsg;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(errorMsg),
              subtitle: const Text(''),
              tileColor: Colors.green.shade200,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ));
      },
    );
  }
}
