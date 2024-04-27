class DashBoardModel {
  String? id;
  dynamic description;
  dynamic language;

  dynamic newsType;
  dynamic img;
  dynamic news_id;
  dynamic news_link;
  dynamic title;
  dynamic video;
  dynamic from;
    dynamic takenby;

  

  DashBoardModel({
    this.id,
    this.description,
    this.language,
    this.img,
    this.newsType,
    this.news_id,
    this.news_link,
    this.title,
    this.video,
    this.from,
    this.takenby
  });

  factory DashBoardModel.fromMap(Map<dynamic, dynamic> data) {
    return DashBoardModel(
      id: data['id'],
      description: data['description'],
      language: data['language'],
      newsType: data['newsType'],
      img: data['img'],
      news_id: data['news_id'],
      news_link: data['news_link'],
      title: data['title'],
      video: data['video'],
      from: data['from'],
        takenby: data['takenby'],

      
    );
  }
  factory DashBoardModel.fromJson(Map<String, dynamic> json) {
    return DashBoardModel(
      id: json['id'],
      description: json['description'],
       newsType: json['newsType'],
          language: json['language'],
   
      img: json['img'],
      news_id: json['news_id'],
      news_link: json['news_link'],
      title: json['title'],
      video: json['video'],
      from: json['from'],
       takenby: json['takenby'],

      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
        'newsType': newsType,
          'language': language,
    
      'img': img,
      'news_id': news_id,
      'news_link': news_link,
      'title': title,
      'video': video,
      'from': from,
       'takenby': takenby,

      
    };
  }
}
