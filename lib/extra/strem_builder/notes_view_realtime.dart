// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learn/notes_app/features/model/notemodel.dart';
import 'package:firebase_learn/extra/future_builder/notes_add.dart';
import 'package:flutter/material.dart';

class NotesViewScreenStream extends StatelessWidget {
  NotesViewScreenStream({super.key});

  late FirebaseFirestore firestore;

  @override
  Widget build(BuildContext context) {
    firestore = FirebaseFirestore.instance;

    return Scaffold(
      floatingActionButton: navigator(context),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore.collection('notes').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade200)),
                );
              },
            );
          } else {
            if (snapshot.hasError) {
              ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade200),
                        child: const Center(
                          child: Text('Could\'t Fetch Notes!!'),
                        )),
                  );
                },
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data!.docs;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var mData = NoteModel.fromMap(data[index].data());
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: Colors.green.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        title: Text(mData.title),
                        subtitle: Text(mData.discription),
                      ));
                },
              );
            }
          }
          return Container();
        },
      ),
    );
  }

  FloatingActionButton navigator(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return NoteAddScreen(
              firestore: firestore,
            );
          },
        ));
      },
      child: const Icon(Icons.add),
    );
  }
}
