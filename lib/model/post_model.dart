class PostModel {

  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? postImage;
  String? text;
  String? postID;
  Map<String, dynamic>? likes;
  List? likesNum;
   List<dynamic>? comments = [];
   List<dynamic>? commentsName = [];
   List<dynamic>? commentsImage = [];
  List? commentsNum;
   bool? myLike;



  PostModel(
      { this.uId,
        this.dateTime,
        this.name,
        this.postImage,
        this.image,
        this.text,
        this.postID,
        this.commentsImage,
        this.comments,
        this.commentsName,
        this.likes,
        this.likesNum,
        this.myLike,
        this.commentsNum,

      });

  PostModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    dateTime = json['dateTime'];
    name = json['name'];
    text = json['text'];
    image = json['image'];
    postImage = json['postImage'];
    commentsImage = json['commentsImage'];
    comments = json['comments'];
    commentsName = json['commentsName'];
    likes = json['likes'];
    likesNum = json['likesNum'];
    myLike = json['myLike'];
    commentsNum = json['commentsNum'];
    postID = json['postID'];




  }
  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'name': name,
      'text': text,
      'uId': uId,
      'image': image,
      'postImage': postImage,
      'postID': postID,
      'commentsImage': commentsImage,
      'comments': comments,
      'commentsName': commentsName,
      'likes': likes,
      'likesNum': likesNum,
      'myLike': myLike,
      'commentsNum': commentsNum,
    };
  }
}
