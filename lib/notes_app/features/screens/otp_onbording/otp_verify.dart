// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learn/notes_app/constrain/style.dart';
import 'package:firebase_learn/notes_app/constrain/variables.dart';
import 'package:firebase_learn/notes_app/features/screens/notes_home/notes_home.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_learn/notes_app/constrain/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerifyScreen extends StatelessWidget {
  OtpVerifyScreen({super.key, required this.verificationCode});
  var otpContoller = TextEditingController();
  String verificationCode;

  @override
  Widget build(BuildContext context) {
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
                children: [
                  const Text(
                    'Enter Verification Code',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  pinCodeField(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t Receive OTP?'),
                      TextButton(
                          onPressed: () {}, child: const Text('RESEND OTP'))
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        var crdential = PhoneAuthProvider.credential(
                          
                            verificationId: verificationCode,
                            smsCode: otpContoller.text.toString());
                        print('Entered OTP : ${otpContoller.text.toString()} ');
                        var auth = FirebaseAuth.instance;

                        var userCred =
                            await auth.signInWithCredential(crdential);
                        var pref = await SharedPreferences.getInstance();
                        pref.setString(loginPrefKey, userCred.user!.uid);

                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return NotesHome(uID: userCred.user!.uid);
                          },
                        ));
                      },
                      style: myButtonStyle(),
                      child: const Text(
                        'Verfiy',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding pinCodeField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: PinCodeTextField(
          keyboardType: TextInputType.number,
          cursorColor: Colors.black,
          animationType: AnimationType.scale,
          controller: otpContoller,
          pastedTextStyle: const TextStyle(fontWeight: FontWeight.bold),
          pinTheme: PinTheme(
              activeFillColor: UIColors.shade300,
              borderWidth: 1,
              borderRadius: BorderRadius.circular(50),
              fieldHeight: 55,
              fieldWidth: 45,
              selectedBorderWidth: 2,
              selectedColor: UIColors.black,
              selectedFillColor: UIColors.shade500,
              inactiveFillColor: UIColors.shade300,
              activeColor: UIColors.shade500,
              inactiveColor: UIColors.shade200),
          enableActiveFill: true,
          appContext: context,
          length: 6),
    );
  }
}
