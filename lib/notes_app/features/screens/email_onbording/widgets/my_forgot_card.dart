// ignore_for_file: must_be_immutable

import 'package:firebase_learn/notes_app/constrain/widget/button.dart';
import 'package:firebase_learn/notes_app/constrain/widget/text_widget.dart';
import 'package:firebase_learn/notes_app/features/screens/email_onbording/onbording_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPasswordCard extends StatelessWidget {
  ResetPasswordCard({super.key, required this.pageContoller});
  PageController pageContoller;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              IconButton(
                  onPressed: () {
                    pageContoller.jumpToPage(1);
                  },
                  icon: const Icon(CupertinoIcons.back)),
              onBordingTitle(title: 'Forgot Password'),
              const SizedBox(width: 20)
            ]),
            const SizedBox(height: 30),
            TextField(
              decoration: myTextFieldDecoration(
                  hintText: 'Email', prefixIcon: Icons.email),
            ),
            const SizedBox(height: 10),
            MyElevatedButton(btName: 'Send Link', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
