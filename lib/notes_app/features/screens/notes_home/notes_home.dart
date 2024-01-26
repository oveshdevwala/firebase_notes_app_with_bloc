// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learn/notes_app/features/bloc/notes_bloc.dart';
import 'package:firebase_learn/notes_app/constrain/colors.dart';
import 'package:firebase_learn/notes_app/features/screens/notes_home/widget/my_profile_drawer.dart';
import 'package:firebase_learn/notes_app/features/screens/add_notes/addnote.dart';
import 'package:firebase_learn/notes_app/features/screens/notes_home/widget/grid_view_builder.dart';
import 'package:firebase_learn/notes_app/features/screens/notes_home/widget/list_view_builder.dart';
import 'package:firebase_learn/notes_app/features/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class NotesHome extends StatefulWidget {
  NotesHome({super.key, required this.uID});
  String uID;

  @override
  State<NotesHome> createState() => _NotesHomeState();
}

class _NotesHomeState extends State<NotesHome> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    context.read<NotesBloc>().add(NotesFetchEvent(uId: widget.uID));
    profileDataFetch();
  }

  profileDataFetch() async {
    await context.read<profilePicProvider>().imgUrl();
    setState(() {});
  }

  bool isGridView = true;
  @override
  Widget build(BuildContext context) {
    var blocPath = context.read<NotesBloc>();
    return Scaffold(
      backgroundColor: UIColors.shade100,
      appBar: AppBar(
        backgroundColor: UIColors.shade100,
        actions: [
          IconButton(
              onPressed: () {
                isGridView = !isGridView;
                setState(() {});
              },
              icon: isGridView == true
                  ? const Icon(Icons.grid_on)
                  : const Icon(Icons.list_sharp)),
          const SizedBox(width: 10)
        ],
      ),
      drawer: MyProfileDrawer(
        firestore: firestore,
        uId: widget.uID,
      ),
      floatingActionButton: navigator(context),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is NotesLoadingState) {
            return isGridView
                ? const NotesGridViewLoadingState()
                : const NotesListViewLoadingState();
          } else if (state is NotesErrorState) {
            return isGridView
                ? NotesGridViewErrorState(errorMsg: state.errMsg)
                : NotesListViewErrorState(errorMsg: state.errMsg);
          } else if (state is NotesLoadedState) {
            var blocData = state.data.docs;
            return blocData.isNotEmpty
                ? isGridView
                    ? NotesGridViewBuilder(blocData: blocData, uId: widget.uID)
                    : ListViewNotes(
                        blocData: blocData,
                        blocPath: blocPath,
                        uID: widget.uID,
                        firestore: firestore)
                : Center(
                    child: LottieBuilder.asset(
                      'assets/emptynotes.json',
                      height: 200,
                    ),
                  );
          }
          return const SizedBox();
        },
      ),
    );
  }

  FloatingActionButton navigator(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: UIColors.shade200,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return AddNotesScreen(
                title: '',
                disc: '',
                index: 0,
                docId: '',
                uId: widget.uID,
                isUpdate: false);
          },
        ));
      },
      child: const Icon(Icons.add),
    );
  }
}
