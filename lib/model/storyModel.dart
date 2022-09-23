import 'package:cloud_firestore/cloud_firestore.dart';

class StoryModel {
  String? name;
  String? uId;
  String? image;
  String? storyImage;
  DateTime? dateTime;
  String? text;

  StoryModel(
      {this.uId,
      this.name,
      this.image,
      this.text,
      this.dateTime,
      this.storyImage});

  StoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    storyImage = json['storyImage'];
    dateTime = (json['date'] as Timestamp).toDate() ;
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'text': text,
      'storyImage': storyImage,
      'date': dateTime,
    };
  }


}
