import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class StatusModel {
  final Timestamp statustimes;
  final String statusdetail;

  StatusModel({
    required this.statustimes,
    required this.statusdetail,

  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statustimes' : statustimes,
      'statusdetail': statusdetail,

    };
  }

  factory StatusModel.fromMap(Map<String, dynamic> map) {
    return StatusModel(
      statustimes: (map['statustimes']),
      statusdetail: (map['statusdetail'] ?? '') as String,
    );
  }

  factory StatusModel.fromJson(String source) => StatusModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
