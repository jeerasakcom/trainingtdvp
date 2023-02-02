import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tdvp/components/backend/products/create_products.dart';
//import 'package:tdvp/components/backend/products/list_products.dart';

import 'package:tdvp/components/backend/products/list.dart';
import 'package:tdvp/components/backend/stock/create_stock.dart';
import 'package:tdvp/models/stock_model.dart';
import 'package:tdvp/utility/category_constant.dart';
import 'package:tdvp/utility/config_form.dart';

import 'package:tdvp/utility/config_progress.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/config_text_button.dart';
import 'package:tdvp/utility/dailog.dart';
import 'package:tdvp/utility/style.dart';

class ListsCategoryPages extends StatefulWidget {
  const ListsCategoryPages({Key? key, required String docStock})
      : super(key: key);

  @override
  _ListsCategoryPagesState createState() => _ListsCategoryPagesState();
}

class _ListsCategoryPagesState extends State<ListsCategoryPages> {
  bool load = true;
  bool? haveStock;
  List<StockModel> stockModels = [];
  var docStocks = <String>[];
  String? newcategory;
  //String? category;

  List<String> category = [
    'แบบพิมพ์ทั่วไปราชการ',
    'แบบพิมพ์สั่งพิมพ์เฉพาะ',
    'แบบพิมพ์ ส.ค.ส./สมุดไดอารี่',
    'แบบพิมพ์สั่งพิมพ์พิเศษระบุชื่อหน่วยงาน',
    'แบบพิมพ์อื่นๆ',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readStock();
  }

  Future<void> readStock() async {
    if (stockModels.isNotEmpty) {
      stockModels.clear();
      docStocks.clear();
    }
    await FirebaseFirestore.instance.collection('stock').get().then((value) {
      print('value ==> ${value.docs}');
      load = false;

      if (value.docs.isEmpty) {
        haveStock = false;
      } else {
        haveStock = true;
        for (var item in value.docs) {
          StockModel stockModel = StockModel.fromMap(item.data());
          stockModels.add(stockModel);
          docStocks.add(item.id);
        }
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 110, 244),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateCategoryPages(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      /* body: load
          ? const ConfigProgress()
          : haveStock!
              ? blocklistscategory()
              : Center(
                  child: ConfigText(
                    lable: 'ไม่มีหมวดหมู่',
                    textStyle: StyleProjects().topicstyle4,
                  ),
                ),
   
    */

/*
      body: load
          ? const ConfigProgress()
          : haveStock!
              ? blocklistscategory()
              : Center(
                  child: ConfigText(
                    lable: 'ไม่มีหมวดหมู่/แบบพิมพ์',
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
              "บริหารจัดการหมวดหมู่/แบบพิมพ์",
              style: StyleProjects().topicstyle2,
            ),
            load
                ? const ConfigProgress()
                : haveStock!
                    ? blocklistscategory()
                    : Center(
                        child: ConfigText(
                          lable: 'ไม่มีหมวดหมู่/แบบพิมพ์',
                          textStyle: StyleProjects().topicstyle4,
                        ),
                      ),
          ],
        ),
      ),
    );
  }

/*
  ListView blocklistscategory() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: stockModels.length,
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.all(10),
        /*
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*
                 Text(
                  "รหัสหมวดหมู่ : ${stockModels[index].id}",
                  softWrap: true,
                  maxLines: 1,
                  style: StyleProjects().topicstyle8,
                ),
                
                Text(
                  "หมวดหมู่ : ${stockModels[index].category}",
                  softWrap: true,
                  maxLines: 1,
                  style: StyleProjects().topicstyle8,
                ),
                */

                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "รหัสหมวดหมู่ : ${stockModels[index].id}",
                        maxLines: 1,
                        style: StyleProjects().topicstyle8,
                      ),
                      Text(
                        "หมวดหมู่ : ${stockModels[index].category}",
                        softWrap: true,
                        maxLines: 1,
                        style: StyleProjects().topicstyle8,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        /*
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListsCategoryPages(
                                  docStock: docStocks[index],
                                ),
                              ));
                        },
                        */
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListsProductsPages(
                                  stockModel: stockModels[index],
                                  docStock: docStocks[index],
                                ),
                              ));
                        },
                        icon: const Icon(Icons.list)),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateProductPages(
                                  stockModel: stockModels[index],
                                  docStock: docStocks[index],
                                ),
                              ));
                        },
                        icon: const Icon(Icons.add_box_outlined)),
                  ],
                ),
              ],
            ),
          ),
        ),
      */
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 1,
          //color: Color.fromARGB(255, 136, 223, 161),
          color: StyleProjects().cardStream5,
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
                        stockModels[index].images,
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
                          Text(
                            "รหัสหมวดหมู่ : ${stockModels[index].id}",
                            softWrap: true,
                            maxLines: 1,
                            style: StyleProjects().topicstyle8,
                          ),
                          Text(
                            "หมวดหมู่ : ${stockModels[index].category}",
                            softWrap: true,
                            maxLines: 1,
                            style: StyleProjects().topicstyle8,
                          ),
                        ],
                      ),
                    ),

//
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListsProductsPages(
                                      stockModel: stockModels[index],
                                      docStock: docStocks[index],
                                    ),
                                  ));
                            },
                            icon: const Icon(Icons.list)),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateProductPages(
                                      stockModel: stockModels[index],
                                      docStock: docStocks[index],
                                    ),
                                  ));
                            },
                            icon: const Icon(Icons.add_box_outlined)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

*/
  Widget blocklistscategory() {
    return SingleChildScrollView(
      child: LayoutBuilder(builder: (context, constarints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /*
            StyleProjects().boxTop2,
            StyleProjects().header2(),
            StyleProjects().boxheight1,
            Text(
              "บริหารจัดการหมวดหมู่/แบบพิมพ์",
              style: StyleProjects().topicstyle2,
            ),
            */
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: stockModels.length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 5,
                    color: StyleProjects().cardStream9,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 75,
                                height: 100,
                                margin: const EdgeInsets.all(10),
                                child: Image.network(
                                  stockModels[index].images,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ConfigText(
                                      lable:
                                          "รหัส : ${stockModels[index].id.toString()}",
                                      textStyle: StyleProjects().contentstyle5,
                                    ),
                                    Text(
                                      "หมวดหมู่ : ${stockModels[index].category}",
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: StyleProjects().contentstyle5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            thickness: 1,
                            // color: Color.fromARGB(255, 255, 255, 255),
                            color: Color(0xff000011),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              height: 100,
                              child: InkWell(
                                child: Column(
                                  children: [
                                    IconButton(
                                      /*
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateProductPages(
                                                stockModel: stockModels[index],
                                                docStock: docStocks[index],
                                              ),
                                            ));
                                      },
                                     
                                     */
                                      //
                                      onPressed: () {
                                        StyleDialog(context: context)
                                            .actionDialog(
                                                title: 'ยืนยันการแก้ไข',
                                                message:
                                                    'คุณต้องการหมวดหมู่แบบพิมพ์นี้ ?',
                                                label1: 'แก้ไข',
                                                label2: 'ยกเลิก',
                                                presFunc1: () {
                                                  processEditStock(
                                                      docStock:
                                                          docStocks[index]);
                                                  Navigator.pop(context);
                                                },
                                                presFunc2: () {
                                                  Navigator.pop(context);
                                                });
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color:
                                            Color.fromARGB(255, 000, 000, 000),
                                      ),
                                    ),
                                    Text(
                                      "แก้ไขหมวดหมู่",
                                      style: StyleProjects().contentstyle5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              height: 100,
                              child: InkWell(
                                child: Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateProductPages(
                                                stockModel: stockModels[index],
                                                docStock: docStocks[index],
                                              ),
                                            ));
                                      },
                                      icon: const Icon(
                                        Icons.add_chart_outlined,
                                        color:
                                            Color.fromARGB(255, 000, 000, 000),
                                      ),
                                    ),
                                    Text(
                                      "เพิ่มแบบพิมพ์",
                                      style: StyleProjects().contentstyle5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              height: 100,
                              child: InkWell(
                                child: Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ListsProductsPages(
                                                stockModel: stockModels[index],
                                                docStock: docStocks[index],
                                              ),
                                            ));
                                      },
                                      icon: const Icon(
                                        Icons.list,
                                        color:
                                            Color.fromARGB(255, 000, 000, 000),
                                      ),
                                    ),
                                    Text(
                                      "รายการแบบพิมพ์",
                                      style: StyleProjects().contentstyle5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              height: 100,
                              child: InkWell(
                                child: Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        StyleDialog(context: context)
                                            .actionDialog(
                                                title: 'ยืนยันการลบ',
                                                message:
                                                    'คุณต้องการลบหมวดหมู่แบบพิมพ์นี้ ?',
                                                label1: 'ลบ',
                                                label2: 'ยกเลิก',
                                                presFunc1: () async {
                                                  print('${docStocks[index]}');

                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('stock')
                                                      .doc(docStocks[index])
                                                      .delete()
                                                      .then((value) {
                                                    readStock();
                                                  });

                                                  Navigator.pop(context);
                                                },
                                                presFunc2: () {
                                                  Navigator.pop(context);
                                                });
                                      },
                                      icon: const Icon(
                                        Icons.delete_outline_outlined,
                                        color:
                                            Color.fromARGB(255, 000, 000, 000),
                                      ),
                                    ),
                                    Text(
                                      "ลบ",
                                      style: StyleProjects().contentstyle5,
                                    ),
                                  ],
                                ),
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

  Future<void> processEditStock({required String docStock}) async {
    await FirebaseFirestore.instance
        .collection('stock')
        .doc(docStock)
        .get()
        .then((value) async {
      StockModel stockModel = StockModel.fromMap(value.data()!);
      TextEditingController nameController = TextEditingController();

      nameController.text = stockModel.category.toString();

      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: ListTile(
              title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "หมวดหมู่ ",
                style: StyleProjects().contentstyle5,
              ),
              Text(
                stockModel.category.toString(),
                style: StyleProjects().contentstyle5,
              ),
            ],
          )),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ConfigForm2(
                    textInputType: TextInputType.text,
                    controller: nameController,
                    label: 'หมวดหมู่',
                    iconData: Icons.list_outlined,
                    changeFunc: (String string) {}),
               // blockprocate(),
              ],
            ),
          ),
          actions: [
            ConfigTextButton(
              label: 'แก้ไข',
              pressFunc: () async {
                Navigator.pop(context);
                String newName = (nameController.text);

                Map<String, dynamic> map = stockModel.toMap();
                // map['category'] = newName;
                map['category'] = newcategory;

                await FirebaseFirestore.instance
                    .collection('stock')
                    .doc(docStock)
                    .update(map)
                    .then((value) {
                  readStock();
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

  Widget blockprocate() {
    return Container(
      child: Column(
        children: [
          const Text(
            'หมวดหมู่แบบพิมพ์',
            style: TextStyle(
              fontFamily: 'THSarabunNew',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff000f3b),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: DropdownButton<String>(
              value: newcategory,
              /*
              items: DataCategory()
                  .positions
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: const TextStyle(
                          fontFamily: 'THSarabunNew',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff000f3b),
                        ),
                      ),
                    ),
                  )
                  .toList(),
                  */
              items: category
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: const TextStyle(
                          fontFamily: 'THSarabunNew',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff000f3b),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  newcategory = value;
                });
              },
              hint: const Text(
                'กรุณาเลือกหมวดหมู่ใหม่ค่ะ',
                style: TextStyle(
                  fontFamily: 'THSarabunNew',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD80000),
                ),
              ),
            ),
          ),
          /*
          Container(
            child: DropdownButton<String>(
              value: category,
              items: DataCategory()
                  .positions
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: const TextStyle(
                          fontFamily: 'THSarabunNew',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff000f3b),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  newcategory = value;
                });
              },
              hint: const Text(
                'กรุณาเลือกหมวดหมู่ใหม่ค่ะ',
                style: TextStyle(
                  fontFamily: 'THSarabunNew',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD80000),
                ),
              ),
            ),
          ),
        */
        ],
      ),
    );
  }
}
