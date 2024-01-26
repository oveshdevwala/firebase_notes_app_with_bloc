// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserProfilSignUpeModel {
  String email;
  String userName;
  String mobileNumber;
  String curruntTime;
  UserProfilSignUpeModel({
    required this.email,
    required this.userName,
    required this.curruntTime,
    required this.mobileNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'email': email,
      'curruntTime': curruntTime,
      "mobileNumber": mobileNumber
    };
  }

  factory UserProfilSignUpeModel.fromMap(Map<String, dynamic> map) {
    return UserProfilSignUpeModel(
        email: map['email'],
        mobileNumber: map['mobileNumber'],
        userName: map['userName'],
        curruntTime: map['curruntTime']);
  }
}
