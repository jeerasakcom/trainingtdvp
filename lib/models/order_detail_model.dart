import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final Timestamp ordertimes;
  final String ordernumber;
  final List<Map<String, dynamic>> customerdetail;
  final List<Map<String, dynamic>> productslists;
  final String status;
  final String ordertotal;
  final String payments;
  final String logistics;
  final String bankstatement;
  OrderModel({
    required this.ordertimes,
    required this.ordernumber,
    required this.customerdetail,
    required this.productslists,
    required this.status,
    required this.ordertotal,
    required this.payments,
    required this.logistics,
    required this.bankstatement,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ordertimes': ordertimes,
      'ordernumber': ordernumber,
      'customerdetail': customerdetail,
      'productslists': productslists,
      'status': status,
      'ordertotal': ordertotal,
      'payments': payments,
      'logistics': logistics,
      'bankstatement': bankstatement,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      ordertimes: (map['ordertimes']),
      ordernumber: map['ordernumber'] as String,
      customerdetail: List<Map<String, dynamic>>.from(map['customerdetail']),
      productslists: List<Map<String, dynamic>>.from(map['productslists']),
      status: (map['status'] ?? '') as String,
      ordertotal: (map['ordertotal'] ?? '') as String,
      payments: (map['payments'] ?? '') as String,
      logistics: (map['logistics'] ?? '') as String,
      bankstatement: (map['bankstatement'] ?? '') as String,
    );
  }

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
