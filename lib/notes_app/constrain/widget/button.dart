// ignore_for_file: must_be_immutable

import 'package:firebase_learn/notes_app/constrain/colors.dart';
import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  MyElevatedButton({super.key, required this.btName, required this.onTap});
  VoidCallback onTap;
  String btName;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: UIColors.shade200,
            foregroundColor: UIColors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12)),
        child: Text(
          btName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ));
  }
}
