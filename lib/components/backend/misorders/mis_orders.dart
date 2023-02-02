import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tdvp/models/order_model.dart';
import 'package:tdvp/models/users_model.dart';
import 'package:tdvp/utility/config_form.dart';
import 'package:tdvp/utility/config_progress.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/config_text_button.dart';
import 'package:tdvp/utility/dailog.dart';
import 'package:tdvp/utility/style.dart';


class OrdersListsPages extends StatefulWidget {
  const OrdersListsPages({
    Key? key,
  }) : super(key: key);

  @override
  State<OrdersListsPages> createState() => _OrdersListsPagesState();
}

class _OrdersListsPagesState extends State<OrdersListsPages> {
  bool load = true;
  bool? haveOrders;
  var userModels = <UserModel>[];
  var docIdUsers = <String>[];
  var orderModels = <OrderModel>[];
  var docIdOrders = <String>[];
  String? newstatus = 'Cancel';

  @override
  void initState() {
    super.initState();
    readerOrders();
  }

  Future<void> readerOrders() async {
    if (orderModels.isNotEmpty) {
      orderModels.clear();
      docIdOrders.clear();

      load = true;
      setState(() {});
    }
    await FirebaseFirestore.instance
        .collection('orders')
        .orderBy('ordertimes', descending: true)
        .get()
        .then((value) {
      print('value ==> ${value.docs}');
      load = false;

      if (value.docs.isEmpty) {
        haveOrders = false;
      } else {
        haveOrders = true;
        for (var item in value.docs) {
          UserModel userModel = UserModel.fromMap(item.data());
          userModels.add(userModel);
          docIdUsers.add(item.id);
          OrderModel orderModel = OrderModel.fromMap(item.data());
          orderModels.add(orderModel);
          docIdOrders.add(item.id);
        }
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? const ConfigProgress()
          : haveOrders!
              ? newContent()
              : Center(
                  child: ConfigText(
                    lable: 'ไม่มีข้อมูล',
                    textStyle: StyleProjects().topicstyle4,
                  ),
                ),
    );
  }

  Widget newContent() {
    return SingleChildScrollView(
      child: LayoutBuilder(builder: (context, constarints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StyleProjects().boxTop2,
            StyleProjects().header2(),
            StyleProjects().boxTop2,
            Text(
              "บริหารจัดการคำสั่งซื้อ",
              style: StyleProjects().topicstyle2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: orderModels.length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    //color: StyleProjects().cardStream2,
                    color: const Color(0xFF9ACD32),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                width: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    /*  Text(
                                      "รหัสคำสั่งซื้อ : ${orderModels[index].ordernumber.toString()}",
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: StyleProjects().contentstyle5,
                                    ),
                                    Text(
                                      orderModels[index]
                                          .ordertimes
                                          .toDate()
                                          .toString()
                                          .substring(0, 16),
                                      style: StyleProjects().contentstyle5,
                                    ),
                                     */
                                    //

                                    /* Text(
                                      orderModels[index].uidcustomer,
                                      style: StyleProjects().topicstyle8,
                                    ), */

                                    Row(
                                      children: [
                                        Text(
                                          "รหัสคำสั่งซื้อ : ",
                                          style: StyleProjects().topicstyle8,
                                        ),
                                        Text(
                                          orderModels[index]
                                              .ordernumber
                                              .toString(),
                                          style: StyleProjects().topicstyle8,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "วันที่สั่งพิมพ์ : ",
                                          style: StyleProjects().topicstyle8,
                                        ),
                                        Text(
                                          orderModels[index]
                                              .ordertimes
                                              .toDate()
                                              .toString()
                                              .substring(0, 16),
                                          style: StyleProjects().topicstyle8,
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Text(
                                          "การรับสินค้า : ",
                                          style: StyleProjects().topicstyle8,
                                        ),
                                        Text(
                                          orderModels[index].logistics,
                                          softWrap: true,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: StyleProjects().topicstyle8,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "การชำระเงิน : ",
                                          style: StyleProjects().topicstyle8,
                                        ),
                                        Text(
                                          orderModels[index].payments,
                                          softWrap: true,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: StyleProjects().topicstyle8,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "จำนวนเงิน : ",
                                          style: StyleProjects().topicstyle8,
                                        ),
                                        Text(
                                          orderModels[index].ordertotal,
                                          style: StyleProjects().topicstyle8,
                                        ),
                                        StyleProjects().boxwidth1,
                                        Text(
                                          "บาท",
                                          style: StyleProjects().topicstyle8,
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Text(
                                          "สถานะ : ",
                                          style: StyleProjects().topicstyle8,
                                        ),
                                        Text(
                                          orderModels[index].status,
                                          style: StyleProjects().topicstyle8,
                                        ),
                                      ],
                                    ),

                                    //
                                  ],
                                ),
                              ),

//
                            ),
                            /*
                            Expanded(
                              flex: 1,
                              child: 
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color:
                                            Color.fromARGB(255, 000, 000, 000)),
                                    onPressed: () {
                                      StyleDialog(context: context)
                                          .actionDialog(
                                              title: 'ยืนยันการแก้ไข',
                                              message: 'คุณต้องการแก้ไข ?',
                                              label1: 'แก้ไข',
                                              label2: 'ยกเลิก',
                                              presFunc1: () {
                                                print(
                                                    '==>> ${docIdUsers[index]}');
                                                processUpdate(
                                                    docIdUsers:
                                                        docIdUsers[index]);

                                                Navigator.pop(context);
                                              },
                                              presFunc2: () {
                                                Navigator.pop(context);
                                              });
                                    },
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        StyleDialog(context: context)
                                            .actionDialog(
                                                title: 'ยืนยันการลบ',
                                                message:
                                                    'คุณต้องการลบข่าวนี้ ?',
                                                label1: 'ลบ',
                                                label2: 'ยกเลิก',
                                                presFunc1: () async {
                                                  print(
                                                      '==> ${docIdUsers[index]}');

                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('users')
                                                      .doc(docIdUsers[index])
                                                      .delete()
                                                      .then((value) {
                                                    readerOrders();
                                                  });

                                                  Navigator.pop(context);
                                                },
                                                presFunc2: () {
                                                  Navigator.pop(context);
                                                });
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Color.fromARGB(255, 219, 49, 49),
                                      )),
                                ],
                              ),
                            ),
                            */

/*
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color:
                                          Color.fromARGB(255, 000, 000, 000)),
                                  onPressed: () {
                                    StyleDialog(context: context).actionDialog(
                                        title: 'ยืนยันการแก้ไข',
                                        message: 'คุณต้องการแก้ไข ?',
                                        label1: 'แก้ไข',
                                        label2: 'ยกเลิก',
                                        presFunc1: () {
                                          print('==>> ${docIdOrders[index]}');
                                          processUpdate(
                                              docIdOrders: docIdOrders[index]);

                                          Navigator.pop(context);
                                        },
                                        presFunc2: () {
                                          Navigator.pop(context);
                                        });
                                  },
                                ),
                                IconButton(
                                    onPressed: () {
                                      StyleDialog(context: context)
                                          .actionDialog(
                                              title: 'ยืนยันการลบ',
                                              message:
                                                  'คุณต้องการลบ admin นี้ ?',
                                              label1: 'ลบ',
                                              label2: 'ยกเลิก',
                                              presFunc1: () async {
                                                print(
                                                    '==> ${docIdOrders[index]}');

                                                await FirebaseFirestore.instance
                                                    .collection('orders')
                                                    .doc(docIdOrders[index])
                                                    .delete()
                                                    .then((value) {
                                                  readerOrders();
                                                });

                                                Navigator.pop(context);
                                              },
                                              presFunc2: () {
                                                Navigator.pop(context);
                                              });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Color.fromARGB(255, 219, 49, 49),
                                    )),
                              ],
                            ),
                          
                          */

                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                        Icons.edit_calendar_outlined,
                                        color:
                                            Color.fromARGB(255, 000, 000, 000)),
                                    //onPressed: () {},
                                    onPressed: () {
                                      StyleDialog(context: context)
                                          .actionDialog(
                                              title: 'ยืนยันการแก้ไข',
                                              message: 'คุณต้องการแก้ไข ?',
                                              label1: 'แก้ไข',
                                              label2: 'ยกเลิก',
                                              presFunc1: () {
                                                print(
                                                    '==>> ${docIdOrders[index]}');
                                                processUpdate(
                                                    docIdOrders:
                                                        docIdOrders[index]);

                                                Navigator.pop(context);
                                              },
                                              presFunc2: () {
                                                Navigator.pop(context);
                                              });
                                    },
                                  ),

                                  IconButton(
                                      /* onPressed: () {
                                        StyleDialog(context: context)
                                            .actionDialog(
                                                title: 'ยกเลิกคำสั่งซื้อ',
                                                message:
                                                    'คุณต้องการยกเลิกคำสั่งซื้อนี้ ?',
                                                label1: 'ยืนยัน',
                                                label2: 'ยกเลิก',
                                                presFunc1: () async {
                                                  /* String newStatus = 'cancel';
                                                  Map<String, dynamic> map = {};
                                                  map['status'] = newStatus;

                                                  FirebaseFirestore.instance
                                                      .collection('orders')
                                                      .doc(docIdOrder)
                                                      //.doc()
                                                      .update(map)
                                                      .then((value) {
                                                    readData();
                                                  }); */

                                                  /* processTakeOrder(
                                                      status: 'cancel'); */
                                                  //  processTakeOrder(newstatus: 'cancel');

                                                  Navigator.pop(context);
                                                },
                                                presFunc2: () {
                                                  Navigator.pop(context);
                                                });
                                      },
                                      */

                                      onPressed: () {
                                        StyleDialog(context: context)
                                            .actionDialog(
                                                title: 'ยกเลิกคำสั่งซื้อ',
                                                message:
                                                    'คุณต้องการยกเลิกคำสั่งซื้อนี้ ?',
                                                label1: 'ยกเลิก',
                                                label2: 'ออก',
                                                presFunc1: () async {
                                                  print(
                                                      '==> ${docIdOrders[index]}');

                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('orders')
                                                      .doc(docIdOrders[index])
                                                      .delete()
                                                      .then((value) {
                                                    readerOrders();
                                                  });

                                                  Navigator.pop(context);
                                                },
                                                presFunc2: () {
                                                  Navigator.pop(context);
                                                });
                                      },
                                      icon: const Icon(
                                        Icons.free_cancellation_outlined,
                                        color: Color.fromARGB(255, 219, 49, 49),
                                      )),

                                  //
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Future<void> processUpdate({required String docIdOrders}) async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(docIdOrders)
        .get()
        .then((value) async {
      OrderModel orderModel = OrderModel.fromMap(value.data()!);
      TextEditingController statusController = TextEditingController();
      statusController.text = orderModel.status.toString();

      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: ListTile(
              title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: prefer_const_constructors
              /*
              Text(
                "ระดับ",
                style: StyleProjects().topicstyle4,
              ),
              StyleProjects().boxwidth1,

              Text(
                userModel.level.toString(),
                style: StyleProjects().topicstyle4,
              ),
              */
              Text(
                orderModel.ordernumber.toString(),
                style: StyleProjects().topicstyle4,
              ),
            ],
          )),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ConfigForm2(
                    controller: statusController,
                    label: 'สถานะ',
                    iconData: Icons.safety_check_outlined,
                    changeFunc: (String string) {}),
              ],
            ),
          ),
          actions: [
            ConfigTextButton(
              label: 'แก้ไข',
              pressFunc: () async {
                Navigator.pop(context);

                String newstatus = (statusController.text);

                Map<String, dynamic> map = orderModel.toMap();

                map['status'] = newstatus;

                await FirebaseFirestore.instance
                    .collection('orders')
                    .doc(docIdOrders)
                    .update(map)
                    .then((value) {
                  readerOrders();
                });
              },
            ),
            ConfigTextButton(
              label: 'ยกเลิก',
              pressFunc: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    });
  }

  Future<void> processTakeOrder({required String newstatus}) async {
    Map<String, dynamic> map = {};
    map['status'] = newstatus;
    FirebaseFirestore.instance
        .collection('orders')
        .doc()
        .update(map)
        .then((value) {
      Navigator.pop(context);
    });
  }
}
