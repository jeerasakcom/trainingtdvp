import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final int id;
  final String name;
  final String detail;
  final int price;
  final int quantity;
  final String images;

  ProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.price,
    required this.quantity,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'detail': detail,
      'price': price,
      'quantity': quantity,
      'images': images,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      detail: map['detail'] as String,
      price: map['price'] as int,
      quantity: map['quantity'] as int,
      images: map['images'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
