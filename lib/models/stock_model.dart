import 'dart:convert';

class StockModel {
  final int id;
  final String category;
  final String images;
  StockModel({
    required this.id,
    required this.category,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'images': images,
    };
  }

  factory StockModel.fromMap(Map<String, dynamic> map) {
    return StockModel(
      id: map['id'] as int,
      category: map['category'],
      images: map['images'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StockModel.fromJson(String source) =>
      StockModel.fromMap(json.decode(source));
}
