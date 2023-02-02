import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tdvp/components/backend/products/create_products.dart';
import 'package:tdvp/models/products_model.dart';
import 'package:tdvp/models/stock_model.dart';
import 'package:intl/intl.dart';
import 'package:tdvp/utility/config_form.dart';
import 'package:tdvp/utility/config_progress.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/config_text_button.dart';
import 'package:tdvp/utility/dailog.dart';
import 'package:tdvp/utility/style.dart';



class ListsProductsPages extends StatefulWidget {
  final StockModel stockModel;
  final String docStock;
  const ListsProductsPages(
      {Key? key, required this.stockModel, required this.docStock})
      : super(key: key);
  @override
  State<ListsProductsPages> createState() => _ListsProductsPagesState();
}

class _ListsProductsPagesState extends State<ListsProductsPages> {
  StockModel? stockModel;
  String? docStock;
  File? file;
  String? images;
  bool load = true;
  bool? haveProduct;
  var productModels = <ProductModel>[];
  var docIdProducts = <String>[];
  final value = NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    super.initState();
    stockModel = widget.stockModel;
    docStock = widget.docStock;
    readProductData();
  }

  Future<void> readProductData() async {
    if (productModels.isNotEmpty) {
      productModels.clear();
      docIdProducts.clear();
    }
    await FirebaseFirestore.instance
        .collection('stock')
        .doc(docStock)
        .collection('products')
        .orderBy('id', descending: true)
        .get()
        .then((value) {
      print('value ==> ${value.docs}');
      load = false;

      if (value.docs.isEmpty) {
        haveProduct = false;
      } else {
        haveProduct = true;
        for (var item in value.docs) {
          ProductModel productModel = ProductModel.fromMap(item.data());
          productModels.add(productModel);
          docIdProducts.add(item.id);
        }
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleProjects().primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 110, 244),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => CreateProductPages(
                  stockModel: stockModel!, docStock: docStock!)),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

/*
      body: load
          ? const ConfigProgress()
          : haveProduct!
              ? newContent()
              : Center(
                  child: ConfigText(
                    lable: 'ไม่มีสินค้า/แบบพิมพ์',
                    textStyle: StyleProjects().topicstyle4,
                  ),
                ),
*/

      body: SingleChildScrollView(
        child: Column(
          children: [
            StyleProjects().boxTop2,
            StyleProjects().header2(),
            StyleProjects().boxheight1,
            Text(
              "บริหารจัดการสินค้า/แบบพิมพ์",
              style: StyleProjects().topicstyle2,
            ),
            load
                ? const ConfigProgress()
                : haveProduct!
                    ? newContent()
                    : Center(
                        child: ConfigText(
                          lable: 'ไม่มีสินค้า/แบบพิมพ์',
                          textStyle: StyleProjects().topicstyle4,
                        ),
                      ),
          ],
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: productModels.length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 1,
                    //color: Color.fromARGB(255, 136, 223, 161),
                    color: StyleProjects().cardStream2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 80,
                                height: 100,
                                margin: const EdgeInsets.all(8),
                                child: Image.network(
                                  productModels[index].images,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                width: 150,
                                height: 120,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ConfigText(
                                      lable:
                                          "รหัส ${productModels[index].id.toString()}",
                                      textStyle: StyleProjects().contentstyle5,
                                    ),
                                    Text(
                                      "แบบ ${productModels[index].name}",
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: StyleProjects().contentstyle5,
                                    ),
                                    ConfigText(
                                      lable:
                                          //"ราคา ${productModels[index].price.toString()} บาท",
                                          "ราคา ${value.format(productModels[index].price)} บาท",
                                      textStyle: StyleProjects().contentstyle5,
                                    ),
                                    ConfigText(
                                      lable:
                                          //"จำนวน ${productModels[index].quantity.toString()} เล่ม",
                                          "จำนวน ${value.format(productModels[index].quantity)} เล่ม",
                                      textStyle: StyleProjects().contentstyle5,
                                    ),
                                  ],
                                ),
                              ),

//
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
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
                                              message:
                                                  'คุณต้องการแก้ไขสินค้า/แบบพิมพ์นี้ ?',
                                              label1: 'แก้ไข',
                                              label2: 'ยกเลิก',
                                              presFunc1: () {
                                                print(
                                                    'Edit Product at docIdProduct ==>> ${docIdProducts[index]}');
                                                processEditProduct(
                                                    docIdProduct:
                                                        docIdProducts[index]);
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
                                                    'คุณต้องการลบสินค้า/แบบพิมพ์นี้ ?',
                                                label1: 'ลบ',
                                                label2: 'ยกเลิก',
                                                presFunc1: () async {
                                                  print(
                                                      'Click Confirm Delete docIdProduct ==> ${docIdProducts[index]}');

                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('stock')
                                                      .doc(docStock)
                                                      .collection('products')
                                                      .doc(docIdProducts[index])
                                                      .delete()
                                                      .then((value) {
                                                    readProductData();
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

  Future<void> processEditProduct({required String docIdProduct}) async {
    await FirebaseFirestore.instance
        .collection('stock')
        .doc(docStock)
        .collection('products')
        .doc(docIdProduct)
        .get()
        .then((value) async {
      ProductModel productModel = ProductModel.fromMap(value.data()!);
      TextEditingController nameController = TextEditingController();
      TextEditingController detailController = TextEditingController();
      TextEditingController priceController = TextEditingController();
      TextEditingController quantityController = TextEditingController();
      nameController.text = productModel.name.toString();
      detailController.text = productModel.detail.toString();
      priceController.text = productModel.price.toString();
      quantityController.text = productModel.quantity.toString();

      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: ListTile(
              title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: prefer_const_constructors
              Text(
                "แบบพิมพ์",
                style: StyleProjects().topicstyle4,
              ),
              StyleProjects().boxwidth1,

              Text(
                productModel.id.toString(),
                style: StyleProjects().topicstyle4,
              ),
            ],
          )),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ConfigForm2(
                    textInputType: TextInputType.text,
                    controller: nameController,
                    label: 'ชื่อแบบพิมพ์',
                    iconData: Icons.list_outlined,
                    changeFunc: (String string) {}),
                ConfigForm2(
                    textInputType: TextInputType.text,
                    controller: detailController,
                    label: 'รายละเอียด',
                    iconData: Icons.list_outlined,
                    changeFunc: (String string) {}),
                ConfigForm2(
                    textInputType: TextInputType.number,
                    controller: priceController,
                    label: 'ราคา',
                    iconData: Icons.attach_money_outlined,
                    changeFunc: (String string) {}),
                ConfigForm2(
                    textInputType: TextInputType.number,
                    controller: quantityController,
                    label: 'จำนวน',
                    iconData: Icons.collections_bookmark_outlined,
                    changeFunc: (String string) {}),
              ],
            ),
          ),
          actions: [
            ConfigTextButton(
              label: 'แก้ไข',
              pressFunc: () async {
                Navigator.pop(context);
                String newName = (nameController.text);
                String newDetail = (detailController.text);
                int newPrice = double.parse(priceController.text).toInt();
                int newQuantity = double.parse(quantityController.text).toInt();

                Map<String, dynamic> map = productModel.toMap();
                map['name'] = newName;
                map['detail'] = newDetail;
                map['price'] = newPrice;
                map['quantity'] = newQuantity;

                await FirebaseFirestore.instance
                    .collection('stock')
                    .doc(docStock)
                    .collection('products')
                    .doc(docIdProduct)
                    .update(map)
                    .then((value) {
                  readProductData();
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
}
