class CommentModel
{
  String?uId;
  String? name;
  String? image;
  String? dateTime;
  String? comment;



  CommentModel ({
    this.uId,
    this.name,
    this.image,
    this.dateTime,
    this.comment,

  });

  CommentModel .fromJson(Map<String, dynamic>? json){
    uId = json!['uId'];
    name = json['name'];
    image = json['image'];
    comment = json['comment'];
    dateTime = json['dateTime'];

  }

  Map<String, dynamic> toMap (){
    return {
      'uId' : uId,
      'name':name,
      'image':image,
      'dateTime':dateTime,
      'comment':comment,

    };
  }
}