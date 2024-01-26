// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learn/notes_app/features/model/notemodel.dart';
import 'package:firebase_learn/notes_app/constrain/colors.dart';
import 'package:firebase_learn/notes_app/features/screens/notes_view/noteview.dart';
import 'package:flutter/material.dart';

class NotesGridViewBuilder extends StatelessWidget {
  NotesGridViewBuilder({
    super.key,
    required this.blocData,
    required this.uId,
  });
  String uId;

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> blocData;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(5),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: blocData.length,
      itemBuilder: (context, index) {
        var docId = blocData[index].id;
        var mData = NoteModel.fromMap(blocData[index].data());
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return NotesViewScreen(
                    docId: docId,
                    uId: uId,
                    index: index,
                    disc: mData.title,
                    title: mData.discription,
                  );
                },
              ));
            },
            child: Container(
                decoration: BoxDecoration(
                    color: UIColors.shade200,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        mData.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        mData.discription,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: UIColors.black38,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}

class NotesGridViewLoadingState extends StatelessWidget {
  const NotesGridViewLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(5),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: Container(
                decoration: BoxDecoration(
                    color: UIColors.shade200,
                    borderRadius: BorderRadius.circular(12)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [],
                  ),
                )),
          ),
        );
      },
    );
  }
}

class NotesGridViewErrorState extends StatelessWidget {
  NotesGridViewErrorState({super.key, required this.errorMsg});
  String errorMsg;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(5),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                  color: UIColors.shade200,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(errorMsg),
                  ))),
        );
      },
    );
  }
}
