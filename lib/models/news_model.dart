import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  final String? title;
  final String? detail;
  final String? images;
  final String? newstimes;

  NewsModel({
    required this.title,
    required this.detail,
    required this.images,
    required this.newstimes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'detail': detail,
      'images': images,
      'newstimes' : newstimes,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      title: map['title'] as String,
      detail: map['detail'] as String,
      images: map['images'] as String,
      newstimes: map['newstimes'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
