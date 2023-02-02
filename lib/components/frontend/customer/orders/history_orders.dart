import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tdvp/components/frontend/customer/orders/detail_orders.dart';
import 'package:tdvp/models/order_model.dart';
import 'package:tdvp/models/users_model.dart';
import 'package:tdvp/utility/config_progress.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/style.dart';

class HistoryOrdersPages extends StatefulWidget {
  const HistoryOrdersPages({Key? key}) : super(key: key);

  @override
  _HistoryOrdersPagesState createState() => _HistoryOrdersPagesState();
}

class _HistoryOrdersPagesState extends State<HistoryOrdersPages> {
  var user = FirebaseAuth.instance.currentUser;
  bool load = true;
  bool? haveData;
  var orderModels = <OrderModel>[];
  var docIdOrders = <String>[];
  var userModelsBuyer = <UserModel>[];

  @override
  void initState() {
    super.initState();
    readOrder();
  }

  Future<void> readOrder() async {
    if (orderModels.isNotEmpty) {
      orderModels.clear();
      docIdOrders.clear();
      userModelsBuyer.clear();
      load = true;
      setState(() {});
    }
    await FirebaseFirestore.instance
        .collection('orders')
        .orderBy('ordertimes', descending: true)
        .get()
        .then((value) async {
      if (value.docs.isEmpty) {
        haveData = false;
      } else {
        for (var item in value.docs) {
          OrderModel orderModel2 = OrderModel.fromMap(item.data());

          if (orderModel2.uidcustomer == user!.uid) {
            var results = item.data()['productslists'];
            var mapOrders = <Map<String, dynamic>>[];
            for (var item in results) {
              mapOrders.add(item);
            }

            OrderModel orderModel = OrderModel(
                ordertimes: item.data()['ordertimes'],
                ordernumber: item.data()['ordernumber'],
                productslists: mapOrders,
                status: item.data()['status'],
                ordertotal: item.data()['ordertotal'],
                payments: item.data()['payments'],
                logistics: item.data()['logistics'],
                uidcustomer: item.data()['uidcustomer'],
                bankstatement: item.data()['bankstatement']);

            print('orderModel ===> ${orderModel.toMap()}');

            /* UserModel userModel =
                await FindUser(uid: orderModel.uidShopper).findUserModel();
            print('userModel ===>> ${userModel.toMap()}');
            
            userModelsBuyer.add(userModel); */

            orderModels.add(orderModel);
            docIdOrders.add(item.id);
          }
        }
        haveData = true;
      }
      load = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        title: const Text('ประวัติรายการสั่งซื้อ'),
      ),
      */
      appBar: AppBar(
        backgroundColor: StyleProjects().primaryColor,
      ),

      /*
      body: load
          ? const ConfigProgress()
          : haveData!
              ? ListView.builder(
                  itemCount: orderModels.length,
                  itemBuilder: (context, index) => InkWell(
                    /*  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailOrderBuyer(
                            orderModel: orderModels[index],
                            docIdOrder: docIdOrders[index],
                          ),
                        )).then((value) => readOrder()), */

                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            newLabel(
                                title: 'วันสั่งของ :',
                                subTitle: changeDateToString(
                                    orderModels[index].ordertimes)),
                            newLabel(
                                title: 'วิธีการรับสินค้า :',
                                subTitle: orderModels[index].logistics),
                            newLabel(
                                title: 'วิธีการชำระสินค้า :',
                                subTitle: orderModels[index].payments),
                            newLabel(
                                title: 'สถาณะ :',
                                subTitle: orderModels[index].status),
                            newLabel(
                                title: 'Total :',
                                subTitle: orderModels[index].ordertotal),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: ConfigText(
                    lable: 'ไม่มีประวัติการสั่งซื้อ',
                    textStyle: StyleProjects().topicstyle4,
                  ),
                ),
    
    */
      body: SingleChildScrollView(
        child: Column(
          children: [
            StyleProjects().boxTop2,
            StyleProjects().header2(),
            StyleProjects().boxTop2,
            Text(
              "ประวัติการสั่งซื้อ/สั่งพิมพ์",
              style: StyleProjects().topicstyle2,
            ),
            load
                ? const ConfigProgress()
                : haveData!
                    ? blocklistsorders()
                    : Center(
                        child: ConfigText(
                          lable: 'ไม่มีประวัติการสั่งซื้อ',
                          textStyle: StyleProjects().topicstyle4,
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  String changeDateToString(Timestamp timestamp) {
    DateFormat dateFormat = DateFormat('dd MMM yyyy');
    DateTime dateTime = timestamp.toDate();
    String string = dateFormat.format(dateTime);
    return string;
  }

  Row newLabel({required String title, required String subTitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ConfigText(lable: title),
        ConfigText(lable: subTitle),
      ],
    );
  }

  Widget blocklistsorders() {
    return SingleChildScrollView(
      child: LayoutBuilder(builder: (context, constarints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: orderModels.length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(5),
                  child: InkWell(
                    //onTap: () {},
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailOrderBuyer(
                            orderModel: orderModels[index],
                            docIdOrder: docIdOrders[index],
                          ),
                        )).then((value) => readOrder()),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        color: StyleProjects().cardStream5,
                        //color: Color.fromARGB(255, 188, 188, 188),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "รหัสการสั่งซื้อ/สั่งพิมพ์ : ",
                                        style: StyleProjects().topicstyle8,
                                      ),
                                      Text(
                                        orderModels[index].ordernumber,
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
                                        "วันที่สั่งพิมพ์ : ",
                                        style: StyleProjects().topicstyle8,
                                      ),
                                      Text(
                                        changeDateToString(
                                            orderModels[index].ordertimes),
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
                                ],
                              ),
                            ),
                            /*
                            StyleProjects().boxheight1,
                            Column(
                              children: [
                                /*
                                StyleProjects().boxwidth1,
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 50,
                                ),
                                StyleProjects().boxwidth1,
                                Text(
                                  "${stockModels[index].category}",
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: StyleProjects().topicstyle6,
                                ),
                                */
                                Row(
                                  children: [
                                    Text(
                                      "วันที่สั่งพิมพ์ : ",
                                      style: StyleProjects().topicstyle8,
                                    ),
                                    Text(
                                      changeDateToString(
                                          orderModels[index].ordertimes),
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: StyleProjects().topicstyle8,
                                    ),
                                  ],
                                ),
                                newLabel(
                                    title: 'วันสั่งของ :',
                                    subTitle: changeDateToString(
                                        orderModels[index].ordertimes)),
                                newLabel(
                                    title: 'วิธีการรับสินค้า :',
                                    subTitle: orderModels[index].logistics),
                                newLabel(
                                    title: 'วิธีการชำระสินค้า :',
                                    subTitle: orderModels[index].payments),
                                newLabel(
                                    title: 'สถาณะ :',
                                    subTitle: orderModels[index].status),
                                newLabel(
                                    title: 'Total :',
                                    subTitle: orderModels[index].ordertotal),
                              ],
                            ),
                            StyleProjects().boxheight1,
                          */
                          ],
                        ),
                      ),
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
}
