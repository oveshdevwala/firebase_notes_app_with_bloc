import 'package:flutter/material.dart';
import 'package:firebase_learn/notes_app/constrain/colors.dart';

myButtonStyle() {
  return ElevatedButton.styleFrom(
      foregroundColor: UIColors.white,
      backgroundColor: UIColors.shade500,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)));
}
