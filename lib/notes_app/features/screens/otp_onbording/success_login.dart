// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:firebase_learn/notes_app/constrain/colors.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({super.key, required this.title});
  String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.shade100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: 300,
            width: double.infinity,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const Text('Your Account Has Been Created')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
