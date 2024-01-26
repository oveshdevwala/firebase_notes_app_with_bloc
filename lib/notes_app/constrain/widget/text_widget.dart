// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class onBordingTitle extends StatelessWidget {
  onBordingTitle({super.key, required this.title});
  String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}