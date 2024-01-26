import 'dart:async';

import 'package:firebase_learn/notes_app/constrain/colors.dart';
import 'package:firebase_learn/notes_app/constrain/variables.dart';
import 'package:firebase_learn/notes_app/features/screens/email_onbording/onbording_screen.dart';
import 'package:firebase_learn/notes_app/features/screens/notes_home/notes_home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      Widget afterSplashScreen = LoginScreen();

      var prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString(loginPrefKey);
      if (userId != null) {
        if (userId != '') {
          afterSplashScreen = NotesHome(uID: userId);
        }
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => afterSplashScreen));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.black,
      body: Center(
        child: SizedBox(
            height: 200,
            width: 300,
            child: Lottie.asset('assets/notes_splash.json')),
      ),
    );
  }
}
