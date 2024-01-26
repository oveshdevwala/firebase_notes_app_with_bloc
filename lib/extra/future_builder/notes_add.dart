// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learn/notes_app/features/model/notemodel.dart';
import 'package:flutter/material.dart';

class NoteAddScreen extends StatelessWidget {
  NoteAddScreen({super.key, required this.firestore, this.docId = ''});
  FirebaseFirestore firestore;
  String docId;

  var titleController = TextEditingController();

  var discController = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: discController,
              decoration: InputDecoration(
                  hintText: 'Discription',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  var callRef = firestore.collection('notes');
                  if (docId == '') {
                    if (titleController.text.isNotEmpty &&
                        discController.text.isNotEmpty) {
                      callRef.add(NoteModel(
                              discription: discController.text.toString(),
                              title: titleController.text.toString())
                          .toMap());
                      titleController.clear();
                      discController.clear();
                      Navigator.pop(context);
                    }
                  } else {
                    callRef
                        .doc(docId)
                        .update(NoteModel(
                                discription: discController.text.toString(),
                                title: titleController.text.toString())
                            .toMap())
                        .then((value) {
                      firestore = FirebaseFirestore.instance;
                      Navigator.pop(context);
                    });
                  }
                },
                child: const Text('Save'))
          ],
        ),
      ),
    );
  }
}
