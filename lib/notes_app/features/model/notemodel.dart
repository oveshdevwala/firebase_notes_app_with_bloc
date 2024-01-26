class NoteModel {
  String title;
  String discription;
  NoteModel({required this.discription, required this.title});

  Map<String, dynamic> toMap() {
    return {'title': title, "discription": discription};
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(discription: map['discription'], title: map['title']);
  }
}
