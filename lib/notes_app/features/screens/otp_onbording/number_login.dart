// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learn/notes_app/constrain/style.dart';
import 'package:firebase_learn/notes_app/features/screens/otp_onbording/otp_verify.dart';
import 'package:flutter/material.dart';

import 'package:firebase_learn/notes_app/constrain/colors.dart';

class OtpLoginScreen extends StatefulWidget {
  const OtpLoginScreen({super.key});

  @override
  State<OtpLoginScreen> createState() => _OtpLoginScreenState();
}

class _OtpLoginScreenState extends State<OtpLoginScreen> {
  @override
  Widget build(BuildContext context) {
    var condtryCode = '91';
    var numberContoller = TextEditingController();
    return Scaffold(
      backgroundColor: UIColors.shade100,
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 300,
            width: double.infinity,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Enter Your Mobile Number',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: numberContoller,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: TextButton(
                              onPressed: () {
                                setState(() {});
                              },
                              child: Text(
                                "+$condtryCode",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: UIColors.black),
                              )),
                          fillColor: UIColors.shade200,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none)),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        var auth = FirebaseAuth.instance;

                        var phoneAuth = auth.verifyPhoneNumber(
                          timeout: const Duration(seconds: 60),
                          phoneNumber: '+91${numberContoller.text.toString()}',
                          verificationCompleted: (phoneAuthCredential) {
                            // print("Verification completed!!");
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Successful')));
                          },
                          verificationFailed: (error) {
                            // print("Verification failed!! $error");
                             ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error :$error')));
                          },
                          codeSent: (String verificationId,
                              int? forceResendingToken) {
                            // Navigate to otp screen
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return OtpVerifyScreen(
                                    verificationCode: verificationId);
                              },
                            ));
                          },
                          codeAutoRetrievalTimeout: (verificationId) {},
                        );
                      },
                      style: myButtonStyle(),
                      child: const Text('Send OTP',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// showMenu(
//                                     color: UIColors.shade100,
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(12)),

//                                     initialValue: condtryCode,
//                                     shadowColor: UIColors.shade100,
//                                     context: context,
//                                     position: RelativeRect.fromDirectional(
//                                         textDirection: TextDirection.ltr,
//                                         start: 40,
//                                         top: 320,
//                                         end: 50,
//                                         bottom: 0),
//                                     items: listOfContryCode
//                                         .map((e) => PopupMenuItem(
//                                               child: Text('+$e'),
//                                               onTap: () {
//                                                 condtryCode = e;
//                                               },
//                                             ))
//                                         .toList());
}
