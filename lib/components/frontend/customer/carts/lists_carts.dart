import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tdvp/models/order_model.dart';
import 'package:tdvp/models/products_model.dart';
import 'package:tdvp/models/sqlite_helper.dart';
import 'package:tdvp/models/sqlite_model.dart';
import 'package:tdvp/utility/config_images_url.dart';
import 'package:tdvp/utility/config_progress.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/dailog.dart';
import 'package:tdvp/utility/style.dart';

class ListsCartsPages extends StatefulWidget {
  const ListsCartsPages({
    Key? key,
  }) : super(key: key);

  @override
  State<ListsCartsPages> createState() => _ListsCartsPagesState();
}

class _ListsCartsPagesState extends State<ListsCartsPages> {
  bool load = true;
  bool? haveData;
  var sqliteModels = <SQLiteModel>[];
  int total = 0;
  late String ordernumber;

  bool displayConfirmOrder = false;
  File? file;
  String? uidBuyer;
  String typeTransfer = 'onShop';
  String typePayment = 'promptPay';

  String urlSlip = '';

  @override
  void initState() {
    super.initState();
    readSQLite();
  }

  Future<void> readSQLite() async {
    if (sqliteModels.isNotEmpty) {
      sqliteModels.clear();
      total = 0;
    }
    await SQLiteHelper().readAllData().then((value) async {
      print('value readSQLite ==> $value');

      if (value.isEmpty) {
        haveData = false;
      } else {
        haveData = true;

        for (var item in value) {
          SQLiteModel sqLiteModel = item;
          sqliteModels.add(sqLiteModel);
          total = total + int.parse(sqLiteModel.sum);
        }
      }

      setState(() {
        load = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ตะกร้า'),
      ),
      body: load
          ? const ConfigProgress()
          : haveData!
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        showHead(),
                        listCart(),
                        const Divider(
                          color: Colors.blue,
                        ),
                        newTotal(),
                        newControlButton(),
                        displayConfirmOrder
                            ? newTypeTransfer()
                            : const SizedBox(),
                        displayConfirmOrder
                            ? newTypePayment()
                            : const SizedBox(),
                        (displayConfirmOrder && (typePayment == 'promptPay'))
                            ? showPromptPay()
                            : displayConfirmOrder
                                ? ElevatedButton(
                                    onPressed: () => processSaveOrder(),
                                    child: const Text('ยืนยันการสั่งซื้อ'),
                                  )
                                : const SizedBox(),
                        file == null
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 32),
                                        width: 250,
                                        height: 250,
                                        child: Image.file(file!),
                                      ),
                                      ElevatedButton(
                                          onPressed: () async {
                                            String nameSlip =
                                                '$uidBuyer${Random().nextInt(1000)}.jpg';
                                            FirebaseStorage firebaseStorage =
                                                FirebaseStorage.instance;
                                            Reference reference =
                                                firebaseStorage
                                                    .ref()
                                                    .child('slip/$nameSlip');
                                            UploadTask uploadTask =
                                                reference.putFile(file!);
                                            await uploadTask
                                                .whenComplete(() async {
                                              await reference
                                                  .getDownloadURL()
                                                  .then((value) async {
                                                urlSlip = value.toString();
                                                print('urlSlip ==> $urlSlip');
                                                processSaveOrder();
                                              });
                                            });
                                          },
                                          child: const Text(
                                              'อัพโหลด สลิปการจ่ายเงิน ยืนยันการสั่งซื้อ'))
                                    ],
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: ConfigText(
                    lable: 'ไม่มีสินค้าในตะกร้า',
                    textStyle: StyleProjects().topicstyle4,
                  ),
                ),
    );
  }

  Column newTypeTransfer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConfigText(
          lable: 'เลือกสะถานที่จัดส่ง',
          textStyle: StyleProjects().topicstyle4,
        ),
        RadioListTile(
          title: const ConfigText(lable: 'รับที่ร้าน'),
          value: 'onShop',
          groupValue: typeTransfer,
          onChanged: (value) {
            setState(() {
              typeTransfer = value.toString();
            });
          },
        ),
        RadioListTile(
          title: const ConfigText(lable: 'เดลิเวอร์รี่'),
          value: 'delivery',
          groupValue: typeTransfer,
          onChanged: (value) {
            setState(() {
              typeTransfer = value.toString();
            });
          },
        ),
      ],
    );
  }

  Column newTypePayment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConfigText(
          lable: 'ช่องทางการชำระเงิน',
          textStyle: StyleProjects().topicstyle4,
        ),
        RadioListTile(
          title: const ConfigText(lable: 'พร้อมเพย์'),
          value: 'promptPay',
          groupValue: typePayment,
          onChanged: (value) {
            setState(() {
              typePayment = value.toString();
            });
          },
        ),
        RadioListTile(
          title: const ConfigText(lable: 'เก็บเงินปลายทาง'),
          value: 'cashDelivery',
          groupValue: typePayment,
          onChanged: (value) {
            setState(() {
              typePayment = value.toString();
            });
          },
        ),
      ],
    );
  }

  Row showPromptPay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            const SizedBox(
              width: 200,
              height: 200,
              child: ConfigImagesUrl(
                  path:
                      'https://www.androidthai.in.th/election/promptpay/promptpay.png'),
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      var response = await Dio().get(
                          "https://www.androidthai.in.th/election/promptpay/promptpay.png",
                          options: Options(responseType: ResponseType.bytes));
                      final result = await ImageGallerySaver.saveImage(
                          Uint8List.fromList(response.data),
                          quality: 60,
                          name: "promptpay");
                      print(result);
                      if (result['isSuccess']) {
                        print('success True');
                        /*
                        MyDialog().normalDialog(
                          context,
                          'Download Success',
                          'ไปเปิดแอพธนาคา และ Scan PromptPay พร้อม เก็บ Slip และ อัพโหลด Slip เพื่อยืนยันการจ่ายเงิน',
                        );
                        */
                        StyleDialog(context: context).normalDialog(
                          title: 'Download Success',
                          message:
                              'ไปเปิดแอพธนาคา และ Scan PromptPay พร้อม เก็บ Slip และ อัพโหลด Slip เพื่อยืนยันการจ่ายเงิน',
                        );
                      } else {
                        print('success False');
                      }
                    },
                    child: const Text('Download PromptPay')),
                const SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                  onPressed: () async {
                    var result = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                        maxWidth: 800,
                        maxHeight: 800);
                    setState(() {
                      file = File(result!.path);
                    });
                  },
                  child: const Text('เลือกสลิปการจ่ายเงิน'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Row newControlButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () async {
            await SQLiteHelper().deleteAllData().then((value) => readSQLite());
          },
          child: const Text('เคลียร์ตะกร้า'),
        ),
        const SizedBox(
          width: 4,
        ),
        ElevatedButton(
            onPressed: () {
              displayConfirmOrder = true;
              setState(() {});
            },
            child: const Text('สั่งซื้อ')),
        const SizedBox(
          width: 4,
        ),
      ],
    );
  }

  Row newTotal() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /*
              ShowText(
                title: 'Total : ',
                textStyle: MyConstant().h3Style(),
              ),
              */
              ConfigText(
                lable: 'Total : ',
                textStyle: StyleProjects().topicstyle4,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child:
              /* ShowText(
            title: '$total',
            textStyle: MyConstant().h3Style(),
          ),
          */
              ConfigText(
            lable: '$total',
            textStyle: StyleProjects().topicstyle4,
          ),
        ),
      ],
    );
  }

  Container showHead() {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade300),
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child:
                /*
            ShowText(
              title: 'ชื่อสินค้า',
              textStyle: MyConstant().h3Style(),
            ),
            */
                ConfigText(
              lable: 'ชื่อสินค้า',
              textStyle: StyleProjects().topicstyle4,
            ),
          ),
          Expanded(
            flex: 1,
            child:
                /*
            ShowText(
              title: 'ราคา',
              textStyle: MyConstant().h3Style(),
*/
                ConfigText(
              lable: 'ราคา',
              textStyle: StyleProjects().topicstyle4,
            ),
          ),
          Expanded(
            flex: 1,
            /*
            child: ShowText(
              title: 'จำนวน',
              textStyle: MyConstant().h3Style(),
            ),
            */

            child: ConfigText(
              lable: 'จำนวน',
              textStyle: StyleProjects().topicstyle4,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
/*
              child: ShowText(
                title: 'รวม',
                textStyle: MyConstant().h3Style(),
              ),
              */
              child: ConfigText(
                lable: 'รวม',
                textStyle: StyleProjects().topicstyle4,
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }

  ListView listCart() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: sqliteModels.length,
      itemBuilder: (context, index) => Row(
        children: [
          Expanded(
            flex: 3,
            child: ConfigText(lable: sqliteModels[index].productname),

            //child: ShowText(title: sqliteModels[index].nameProduct),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: ConfigText(lable: sqliteModels[index].price),
            ),
            //child: Center(child: ShowText(title: sqliteModels[index].price)),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: ConfigText(lable: sqliteModels[index].quantity),
            ),
            // child: Center(child: ShowText(title: sqliteModels[index].quantity)),
          ),
          Expanded(
            flex: 1,
            child: ConfigText(lable: sqliteModels[index].sum),

            // child: Center(child: ShowText(title: sqliteModels[index].sum)),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () async {
                await SQLiteHelper()
                    .deleteValueFromId(sqliteModels[index].id!)
                    .then((value) => readSQLite());
              },
              icon: const Icon(Icons.delete_forever),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> processSaveOrder() async {
    var mapOrders = <Map<String, dynamic>>[];
    for (var item in sqliteModels) {
      mapOrders.add(item.toMap());
    }

    Timestamp dateOrder = Timestamp.fromDate(DateTime.now());

    OrderModel orderModel = OrderModel(
        ordertimes: dateOrder,
        ordernumber: 'tdvp${Random().nextInt(1000000)}',
        productslists: mapOrders,
        status: 'order',
        ordertotal: total.toString(),
        payments: typePayment,
        logistics: typeTransfer,
        bankstatement: urlSlip,
        uidcustomer: '');

    DocumentReference reference =
        FirebaseFirestore.instance.collection('order').doc();

    await reference.set(orderModel.toMap()).then((value) async {
      String docId = reference.id;
      print('## Save Order Success $docId');

      // ระบบตัด Stock และ Clear ตระกล้า

      for (var item in sqliteModels) {
        await FirebaseFirestore.instance
            .collection('stock')
            .doc(item.docStock)
            .collection('products')
            .doc(item.docProduct)
            .get()
            .then((value) async {
          ProductModel productModel = ProductModel.fromMap(value.data()!);
          int newquantityProduct =
              productModel.quantity - int.parse(item.quantity);

          Map<String, dynamic> data = {};
          data['quantity'] = newquantityProduct;

          await FirebaseFirestore.instance
              .collection('stock')
              .doc(item.docStock)
              .collection('products')
              .doc(item.docProduct)
              .update(data)
              .then((value) {
            print('Success Update ${item.productname}');
          });
        });
      }
      /*
      await SQLiteHelper().deleteAllData().then((value) async {
        UserModel userModel =
            await ConfigProcess().findUserModel(uid: orderModel.uidShopper);

        await MyProcess()
            .sentNotification(
                title: 'มีรายการสั่งสินค้า',
                body: 'มีีรายการสั่งซื้อสินค้า จาก ลูกค้าครับ',
                token: userModel.token!)
            .then((value) {
          // readSQLite();
          Navigator.pushNamedAndRemoveUntil(
              context, MyConstant.routServiceBuyer, (route) => false);
        });
      }
      
      );
      */
    });
  }
}
