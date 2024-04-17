import 'dart:core';

class NewsModel {
  late String? title;
  late String? description;
  late String? urlToImage;
  NewsModel({this.title, this.description, this.urlToImage});

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        urlToImage: json["urlToImage"] ?? '',
      );
  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "urlToImage": urlToImage,
      };
}
