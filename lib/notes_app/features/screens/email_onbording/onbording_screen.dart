// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learn/notes_app/constrain/colors.dart';
import 'package:firebase_learn/notes_app/features/screens/email_onbording/widgets/my_forgot_card.dart';
import 'package:flutter/material.dart';

import 'widgets/my_login_card.dart';
import 'widgets/my_sign_up_card.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  int selectedPageIndex = 0;
  var fireAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var pageContoller = PageController();
    return Scaffold(
      backgroundColor: UIColors.shade100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 475,
            width: 400,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                  minHeight: 330, maxHeight: 450, maxWidth: double.infinity),
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageContoller,
                children: [
                  MySignUpCard(pageContoller: pageContoller),
                  MyLoginCard(pageContoller: pageContoller),
                  ResetPasswordCard(pageContoller: pageContoller)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration myTextFieldDecoration({
  required String hintText,
  required IconData prefixIcon,
  IconButton? sufixIcon,
}) {
  return InputDecoration(
    fillColor: UIColors.shade100,
    filled: true,
    hintText: hintText,
    prefixIcon: Icon(prefixIcon),
    suffixIcon: sufixIcon ?? const SizedBox(),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
  );
}
