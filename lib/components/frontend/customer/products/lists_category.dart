import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tdvp/components/backend/products/create_products.dart';
import 'package:tdvp/components/backend/products/list.dart';
import 'package:tdvp/components/backend/stock/create_stock.dart';
import 'package:tdvp/models/stock_model.dart';
import 'package:tdvp/utility/config_progress.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/style.dart';



class ListsCategoryPages extends StatefulWidget {
  const ListsCategoryPages(
      {Key? key,  required String docStock})
      : super(key: key);

  @override
  _ListsCategoryPagesState createState() => _ListsCategoryPagesState();
}

class _ListsCategoryPagesState extends State<ListsCategoryPages> {
  bool load = true;
  bool? haveStock;
  // List<StockModel> stockModels = [];
  var docStocks = <String>[];
  String? idDocUser;

  bool? haveProduct;
  var stockModels = <StockModel>[];
  var idStocks = <String>[];

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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StyleProjects().boxTop2,
            StyleProjects().header2(),
            StyleProjects().boxheight1,
            Text(
              "หมวดหมู่แบบพิมพ์",
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

  Widget blocklistscategory() {
    return SingleChildScrollView(
      child: LayoutBuilder(builder: (context, constarints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: stockModels.length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(5),
                  /*
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 5,
                    color: StyleProjects().cardStream9,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            /*
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
                            */
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    /*
                                    ConfigText(
                                      lable:
                                          "รหัส : ${stockModels[index].id.toString()}",
                                      textStyle: StyleProjects().contentstyle5,
                                    ),
                                   */
                                    Text(
                                      "${stockModels[index].category}",
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: StyleProjects().topicstyle4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        /*
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
                                      onPressed: () {},
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
                   
                   
                   */

                      ],
                    ),
                  ),
               
               



               */

                  child: InkWell(
                    
                    onTap: () {
                      /*
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CorporateScreen())
                              );
                              */
                    },
                    
                    /*
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListsProductWhereCategory(
                            idStock: idStocks[index],

                          ),
                        )),
                        */
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        //color: const Color(0xffb3e5fc),
                        color: StyleProjects().cardStream10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            StyleProjects().boxheight1,
                            Row(
                              children: [
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
                              ],
                            ),
                            StyleProjects().boxheight1,
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
