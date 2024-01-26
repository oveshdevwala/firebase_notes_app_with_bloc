// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProfilePictureModel {
  String time;
  String imgUrl;
  ProfilePictureModel({
    required this.time,
    required this.imgUrl,
  });

  Map<String, dynamic> toMap() {
    return {'uploadTime': time, 'imgUrl': imgUrl};
  }

  factory ProfilePictureModel.fromMap(Map<String, dynamic> map) {
    return ProfilePictureModel(time: map['uploadTime'], imgUrl: map['imgUrl']);
  }
}
