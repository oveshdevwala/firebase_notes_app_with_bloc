// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_learn/notes_app/constrain/colors.dart';
import 'package:firebase_learn/notes_app/constrain/variables.dart';
import 'package:firebase_learn/notes_app/constrain/widget/button.dart';
import 'package:firebase_learn/notes_app/features/screens/email_onbording/splash_screen.dart';
import 'package:firebase_learn/notes_app/features/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileDrawer extends StatelessWidget {
  MyProfileDrawer({super.key, required this.firestore, required this.uId});
  FirebaseFirestore firestore;
  String uId;
  var fireStore = FirebaseFirestore.instance;

  var selected = false;

  @override
  Widget build(BuildContext context) {
    var provider = context.read<profilePicProvider>();

    return Drawer(
      backgroundColor: UIColors.shade100,
      width: 330,
      child: Consumer<profilePicProvider>(builder: (context, value, child) {
        return Column(
          children: [
            const SizedBox(height: 70),
            // editable profile button
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    style:
                        IconButton.styleFrom(backgroundColor: UIColors.black12),
                    onPressed: () {
                      value.editable = !value.editable;
                    },
                    icon: Icon(
                      value.editable ? Icons.edit_off : Icons.edit_document,
                      color: UIColors.black,
                    ))),

            value.croopedImage != null
                ? CircleAvatar(
                    radius: 60,
                    backgroundImage: FileImage(File(value.croopedImage!.path)))
                : CircleAvatar(
                    radius: 60,
                    backgroundImage: value.profilePicture != null
                        ? NetworkImage(value.profilePicture!)
                        : null,
                    child: value.profilePicture == null
                        ? InkWell(
                            onLongPress: () {
                              value.editable = !value.editable;
                            },
                            child: const Icon(
                              Icons.upload,
                              size: 50,
                            ),
                          )
                        : const SizedBox(),
                  ),
            const SizedBox(height: 10),
            // select and upload buttons
            value.editable
                ? SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              // value.imagePicker();
                              provider.chooseImage(context);
                            },
                            style: drawerElevatedButtonStyle(),
                            child: const Text('Choose Image')),
                        const SizedBox(height: 10),
                        myProfileDetails(value),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 150,
                            child: FittedBox(
                              child: ElevatedButton(
                                  style: drawerElevatedButtonStyle(),
                                  child: const Text('Update Profile'),
                                  onPressed: () {
                                    if (value.croopedImage != null) {
                                      provider.uploadImage(context);
                                    }
                                    context
                                        .read<profilePicProvider>()
                                        .UpdateProfile(context);
                                  }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : myProfileDetails(value),
            const SizedBox(height: 20),
            mylogoutButton(context),
            const SizedBox(height: 20),
          ],
        );
      }),
    );
  }

  Widget myProfileDetails(profilePicProvider value) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          profileTextField(
              value: value,
              hint: value.userName,
              controller: value.userNameController),
          const SizedBox(height: 5),
          profileTextField(
              value: value,
              hint: value.userEmail,
              controller: value.userEmailController),
          const SizedBox(height: 5),
          profileTextField(
              value: value,
              hint: value.userMobileNumber,
              controller: value.userMobileNumberController),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget profileTextField(
      {required profilePicProvider value,
      required String hint,
      required TextEditingController controller}) {
    return SizedBox(
      width: double.infinity,
      // height: 45,
      child: TextField(
        controller: controller,
        enabled: value.editable,
        focusNode: FocusNode(canRequestFocus: true),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(5),
            hintText: hint,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide())),
      ),
    );
  }

  drawerElevatedButtonStyle() => ElevatedButton.styleFrom(
      foregroundColor: UIColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: UIColors.shade300);

  Padding mylogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
          width: double.infinity,
          child: MyElevatedButton(
              btName: 'Logout',
              onTap: () async {
                var prefs = await SharedPreferences.getInstance();
                prefs.setString(loginPrefKey, '');
                Navigator.pop(context);
                Timer(const Duration(milliseconds: 200), () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SplashScreen(),
                      ));
                });
              })),
    );
  }
}
