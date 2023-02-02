import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tdvp/components/frontend/customer/category/lists_category_products.dart';
import 'package:tdvp/models/stock_model.dart';
import 'package:tdvp/utility/config_progress.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/style.dart';


class AllCategoryPages extends StatefulWidget {
  final String idDocUser;
  const AllCategoryPages({
    Key? key,
    required this.idDocUser,
  }) : super(key: key);

  @override
  State<AllCategoryPages> createState() => _AllCategoryPagesState();
}

class _AllCategoryPagesState extends State<AllCategoryPages> {
  String? idDocUser;
  bool load = true;
  bool? haveProduct;
  var stockModels = <StockModel>[];
  var idStocks = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idDocUser = widget.idDocUser;
    readProduct();
  }

  Future<void> readProduct() async {
    await FirebaseFirestore.instance.collection('stock').get().then((value) {
      print('value ==>> ${value.docs}');

      if (value.docs.isEmpty) {
        haveProduct = false;
      } else {
        haveProduct = true;
        for (var item in value.docs) {
          StockModel stockModel = StockModel.fromMap(item.data());
          stockModels.add(stockModel);

          idStocks.add(item.id);
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
      // appBar: AppBar(actions: [ShowAddCart()],
      // backgroundColor: MyConstant.primart,
      //title: Text('สินค้า'),),
      appBar: AppBar(),
      /*
      body: load
          ? const ConfigProgress()
          : haveProduct!
              ? ListView.builder(
                  itemCount: stockModels.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListsProductWhereCategory(
                            idStock: idStocks[index],
                          ),
                        )),
                    child: Card(
                      color: StyleProjects().cardStream10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: ConfigText(lable: stockModels[index].category),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: ConfigText(
                  lable: 'ยังไม่มีสินค้า',
                  textStyle: StyleProjects().topicstyle4,
                )),
   
   */

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
                : haveProduct!
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
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListsProductWhereCategory(
                            idStock: idStocks[index],
                          ),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        color: StyleProjects().cardStream10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
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
                                  style: StyleProjects().topicstyle2,
                                ),
                              ],
                            ),
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
