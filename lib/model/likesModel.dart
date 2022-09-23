class LikesModel
{
  String?uId;
  String? name;
  String? image;
  String? dateTime;



  LikesModel ({
    this.uId,
    this.name,
    this.image,
    this.dateTime,

  });

  LikesModel .fromJson(Map<String, dynamic> json){
    uId = json['uId'];
    name = json['name'];
    image = json['image'];
    dateTime = json['dateTime'];


  }

  Map<String, dynamic> toMap (){
    return {
      'uId' : uId,
      'name':name,
      'image':image,
      'dateTime':dateTime,


    };
  }
}