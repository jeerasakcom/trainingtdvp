import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tdvp/models/order_model.dart';
import 'package:tdvp/models/users_model.dart';
import 'package:tdvp/utility/config_button.dart';
import 'package:tdvp/utility/config_process.dart';
import 'package:tdvp/utility/config_progress.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/style.dart';

class MISOrdersPages extends StatefulWidget {
  final String docIdOrder;
  const MISOrdersPages({
    Key? key,
    required this.docIdOrder,
  }) : super(key: key);

  @override
  State<MISOrdersPages> createState() => _MISOrdersPagesState();
}

class _MISOrdersPagesState extends State<MISOrdersPages> {
  String? docIdOrder;
  bool load = true;
  OrderModel? orderModel;
  UserModel? userModel;
  String? ordernumber;

  @override
  void initState() {
    super.initState();
    docIdOrder = widget.docIdOrder;
    readOrder();
  }

  Future<void> findDetailBuyer() async {
    await ConfigProcess()
        .findUserModel(uid: orderModel!.uidcustomer)
        .then((value) {
      setState(() {
        userModel = value;
      });
    });
  }

  Future<void> readOrder() async {
    //await
    FirebaseFirestore.instance
        .collection('orders')
        // .doc(docIdOrder)
        .doc()
        .get()
        .then((value) {
      orderModel = OrderModel.fromMap(value.data()!);
      load = false;
      setState(() {});
      findDetailBuyer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียด บิลสั่งซื้อ'),
        backgroundColor: StyleProjects().baseColor,
      ),
      body: load
          ? const ConfigProgress()
          : Column(
              children: [
                newLabel(
                  title: 'หมายเลขบิล :',
                  subTitle: orderModel!.ordernumber,
                ),
                newLabel(
                    title: 'วันสั่งสินค้า :',
                    subTitle: changeDateToString(orderModel!.ordertimes)),
                newLabel(
                    title: 'วิธีรับสินค้า :', subTitle: orderModel!.logistics),
                newLabel(
                    title: 'วิธีชำระสินค้า :', subTitle: orderModel!.payments),
                newLabel(title: 'สถานะ :', subTitle: orderModel!.status),
                newLabel(
                    title: 'ที่อยู่จัดส่ง :',
                    subTitle: userModel == null ? '' : userModel!.address!),
                Divider(
                  color: StyleProjects().baseColor,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ConfigText(lable: 'รายการ'),
                    ),
                    Expanded(
                      flex: 1,
                      child: ConfigText(lable: 'ราคา'),
                    ),
                    Expanded(
                      flex: 1,
                      child: ConfigText(lable: 'จำนวน'),
                    ),
                    Expanded(
                      flex: 1,
                      child: ConfigText(lable: 'รวม'),
                    ),
                  ],
                ),
                Divider(
                  color: StyleProjects().baseColor,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: orderModel!.productslists.length,
                  itemBuilder: (context, index) => Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ConfigText(
                          lable: orderModel!.productslists[index]['name'],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ConfigText(
                          lable: orderModel!.productslists[index]['price'],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ConfigText(
                          lable: orderModel!.productslists[index]['quantity'],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ConfigText(
                          lable: orderModel!.productslists[index]['sum'],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: StyleProjects().baseColor,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ConfigText(
                            lable: 'ผลรวมทั้งหมด :   ',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ConfigText(
                        lable: orderModel!.ordertotal,
                      ),
                    ),
                  ],
                ),
                orderModel!.status == 'order'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              ConfigButton(
                                label: 'ยืนยันคำสั่งซื้อ',
                                pressFunc: () {
                                  processTakeOrder(status: 'receive');
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ConfigButton(
                                label: 'ยกเลิกคำสั่งซื้อ',
                                pressFunc: () {
                                  processTakeOrder(status: 'cancel');
                                },
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox()
              ],
            ),
    );
  }

  Future<void> processTakeOrder({required String status}) async {
    /* UserModel userModel =
        await MyProcess().findUserModel(uid: orderModel!.uidBuyer);
    await MyProcess().sentNotification(
        title: '$status รายการสั่งซื่อ',
        body: 'ทางร้าน ได้ $status รายการสั่งซื่อของคุณลูกค้า',
        token: userModel.token!); */

    Map<String, dynamic> map = {};
    map['status'] = status;
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(docIdOrder)
        .update(map)
        .then((value) {
      Navigator.pop(context);
    });
  }

  Row newLabel({required String title, required String subTitle}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: ConfigText(
            lable: title,
            textStyle: StyleProjects().contentstyle5,
          ),
        ),
        Expanded(
          flex: 1,
          child: ConfigText(
            lable: subTitle,
            textStyle: StyleProjects().contentstyle5,
          ),
        ),
      ],
    );
  }

  String changeDateToString(Timestamp timestamp) {
    DateFormat dateFormat = DateFormat('dd MMM yyyy');
    DateTime dateTime = timestamp.toDate();
    String string = dateFormat.format(dateTime);
    return string;
  }
}
