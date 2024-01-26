// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learn/notes_app/constrain/colors.dart';
import 'package:firebase_learn/notes_app/constrain/variables.dart';
import 'package:firebase_learn/notes_app/constrain/widget/button.dart';
import 'package:firebase_learn/notes_app/constrain/widget/text_widget.dart';
import 'package:firebase_learn/notes_app/features/model/user_profile_model.dart';
import 'package:firebase_learn/notes_app/features/screens/email_onbording/onbording_screen.dart';
import 'package:firebase_learn/notes_app/features/screens/otp_onbording/number_login.dart';
import 'package:firebase_learn/notes_app/features/screens/notes_home/notes_home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySignUpCard extends StatelessWidget {
  MySignUpCard({
    super.key,
    required this.pageContoller,
  });
  PageController pageContoller;
  var namecontoller = TextEditingController();
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
            onBordingTitle(title: 'Create Your Account'),
            const SizedBox(height: 20),
            TextField(
              controller: namecontoller,
              decoration: myTextFieldDecoration(
                  hintText: 'First Name', prefixIcon: Icons.person_2_outlined),
            ),
            const SizedBox(height: 10),
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
                  'Already Have a Account?',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                TextButton(
                    onPressed: () {
                      pageContoller.jumpToPage(1);
                    },
                    child: Text('Login Now',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: UIColors.primary)))
              ],
            ),
            mySignUpButton(context),
            const SizedBox(height: 10),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OtpLoginScreen(),
                      ));
                },
                child: const Text('Login With Number'))
          ],
        ),
      ),
    );
  }

  SizedBox mySignUpButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MyElevatedButton(
        btName: 'Sign Up',
        onTap: () async {
          var fireAuth = FirebaseAuth.instance;
          var fireStore = FirebaseFirestore.instance;
          var currentDate = DateTime.now().millisecondsSinceEpoch;
          try {
            var userCred = await fireAuth.createUserWithEmailAndPassword(
                email: emailcontoller.text.toString(),
                password: passcontoller.text.toString());
            var uID = userCred.user!.uid;
            // fireStore.collection('user').doc(uID).set({
            //   'name': namecontoller.text.toString(),
            //   'email': userCred.user!.email,
            //   'createdDate': currentDate
            // });
            fireStore.collection('user').doc(uID).set(UserProfilSignUpeModel(
                    email: userCred.user!.email!,
                    mobileNumber: 'Update Number',
                    userName: namecontoller.text.toString(),
                    curruntTime: currentDate.toString())
                .toMap());
            var pref = await SharedPreferences.getInstance();
            pref.setString(loginPrefKey, uID);
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return NotesHome(
                  uID: uID,
                );
              },
            ));
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Make Strong Password!!!')));
            } else if (e.code == 'email-already-in-use') {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Account Already Found!!!'),
                  TextButton(
                      onPressed: () {
                        pageContoller.jumpToPage(1);
                      },
                      child: Text('Login Now',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: UIColors.primary)))
                ],
              )));
            }
          } catch (e) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Error : $e')));
          }
        },
      ),
    );
  }
}
