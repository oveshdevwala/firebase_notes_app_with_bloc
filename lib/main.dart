import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_learn/firebase_options.dart';
import 'package:firebase_learn/notes_app/features/bloc/notes_bloc.dart';
import 'package:firebase_learn/notes_app/features/screens/email_onbording/splash_screen.dart';
import 'package:firebase_learn/notes_app/features/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  //setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    BlocProvider(
      create: (context) => NotesBloc(firestore: FirebaseFirestore.instance),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => profilePicProvider(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
