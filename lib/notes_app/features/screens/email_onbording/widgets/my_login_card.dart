// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learn/notes_app/constrain/colors.dart';
import 'package:firebase_learn/notes_app/constrain/variables.dart';
import 'package:firebase_learn/notes_app/constrain/widget/button.dart';
import 'package:firebase_learn/notes_app/constrain/widget/text_widget.dart';
import 'package:firebase_learn/notes_app/features/screens/email_onbording/onbording_screen.dart';
import 'package:firebase_learn/notes_app/features/screens/notes_home/notes_home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLoginCard extends StatelessWidget {
  MyLoginCard({
    super.key,
    required this.pageContoller,
  });
  PageController pageContoller;
  var emailcontoller = TextEditingController();
  var passcontoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            onBordingTitle(title: 'Login Your Account'),
            const SizedBox(height: 20),
            TextField(
              controller: emailcontoller,
              decoration: myTextFieldDecoration(
                  hintText: 'Email', prefixIcon: Icons.email_outlined),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passcontoller,
              decoration: myTextFieldDecoration(
                  hintText: 'Password',
                  sufixIcon: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
                  prefixIcon: Icons.password),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t Have a Account?',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                TextButton(
                    onPressed: () {
                      pageContoller.jumpToPage(0);
                    },
                    child: Text('Create Account',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: UIColors.primary)))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      pageContoller.jumpToPage(2);
                    },
                    child: Text('Forgot Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: UIColors.primary))),
                const Text(
                  '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: MyElevatedButton(
                onTap: () async {
                  var fireAuth = FirebaseAuth.instance;
                  try {
                    //login user with email and password
                    var userCred = await fireAuth.signInWithEmailAndPassword(
                      email: emailcontoller.text.toString(),
                      password: passcontoller.text.toString(),
                    );
                    //userid
                    var uID = userCred.user!.uid;
                    // store into Shareprefrences for one time login
                    var pref = await SharedPreferences.getInstance();
                    pref.setString(loginPrefKey, uID);
                    // navigate after login successfully
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return NotesHome(
                          uID: uID,
                        );
                      },
                    ));
                    // firebase error check and return snackbar
                  } on FirebaseAuthException catch (e) {
                    //account not found
                    if (e.code == 'user-not-found') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Account Not Found\nplease Create Account First!!!')));
                      //wrong password
                    } else if (e.code == 'wrong-password') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('your Password Is Wrong')));
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('$e')));
                    }
                    //other error check and return error snack bar
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Error : $e')));
                  }
                },
                btName: 'Login',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
