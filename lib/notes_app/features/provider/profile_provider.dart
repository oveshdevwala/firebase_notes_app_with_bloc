// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_learn/notes_app/constrain/variables.dart';
import 'package:firebase_learn/notes_app/features/model/user_profile_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profilePicProvider extends ChangeNotifier {
  var firestore = FirebaseFirestore.instance;
  CroppedFile? croopedImage;
  var imagePicker;
  var profilePicture;
  var userEmail;
  var userName;
  var userMobileNumber;

  var userNameController = TextEditingController();
  var userEmailController = TextEditingController();
  var userMobileNumberController = TextEditingController();

  var _editable = false;
  get editable => _editable;
  set editable(value) {
    _editable = value;
    notifyListeners();
  }

  imgUrl() async {
    var pref = await SharedPreferences.getInstance();
    var uID = pref.getString(loginPrefKey);
    var user = await firestore.collection('user').doc(uID).get();
    profilePicture = user.data()!['imgUrl'];

    var profileData = UserProfilSignUpeModel.fromMap(user.data()!);
    userEmail = profileData.email;
    userName = profileData.userName;
    userMobileNumber = profileData.mobileNumber;
    notifyListeners();
  }

  getUID() async {
    var pref = await SharedPreferences.getInstance();
    var getUid = pref.getString(loginPrefKey);
    notifyListeners();
    return getUid;
  }

  chooseImage(BuildContext context) async {
    imagePicker = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imagePicker != null) {
      croopedImage = await ImageCropper().cropImage(
        sourcePath: imagePicker.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );
    }
    notifyListeners();
  }

  uploadImage(BuildContext context) async {
    var currentTime = DateTime.now().millisecondsSinceEpoch;
    var fireBucket = FirebaseStorage.instance;
    var storgRef =
        fireBucket.ref().child('image/profilePictures/IMG_$currentTime.jpg');
    _editable = false;
    try {
      storgRef.putFile(File(croopedImage!.path)).then((value) async {
        var imgUrl = await value.ref.getDownloadURL();
// update profile picture
        var pref = await SharedPreferences.getInstance();
        var uID = pref.getString(loginPrefKey);
        firestore
            .collection('user')
            .doc(uID)
            .update({'imgUrl': imgUrl.toString()});

        profilePicture = imgUrl.toString();
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }

    notifyListeners();
  }

  UpdateProfile(BuildContext context) async {
    var pref = await SharedPreferences.getInstance();
    var uID = pref.getString(loginPrefKey);
    var curruntTime = DateTime.now().millisecondsSinceEpoch;
    if (userEmailController.text.isNotEmpty &&
        userNameController.text.isNotEmpty &&
        userMobileNumberController.text.isNotEmpty) {
      firestore.collection('user').doc(uID).update(UserProfilSignUpeModel(
              email: userEmailController.text.toString(),
              userName: userNameController.text.toString(),
              curruntTime: curruntTime.toString(),
              mobileNumber: userMobileNumberController.text.toString())
          .toMap());
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Profile Updated')));
    } else if (userEmailController.text == userEmail &&
        userNameController.text == userName &&
        userMobileNumberController.text == userMobileNumber) {
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Field Can\'t Blank')));
    }
    var user = await firestore.collection('user').doc(uID).get();
    var profileData = UserProfilSignUpeModel.fromMap(user.data()!);
    userEmailController.text = profileData.email;
    userNameController.text = profileData.userName;
    userMobileNumberController.text = profileData.mobileNumber;
    _editable = false;
    notifyListeners();
  }
}




// list of profile pictures user add on storage
// fireStore
//     .collection('user')
//     .doc(widget.uId)
//     .collection('profilePics')
//     .add(ProfilePictureModel(
//             time: currentTime.toString(), imgUrl: imgUrl.toString())
//         .toMap());y
