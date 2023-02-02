import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tdvp/components/frontend/products/show_add_cart.dart';
import 'package:tdvp/components/frontend/products/show_list_product_where_cat.dart';
import 'package:tdvp/models/stock_model.dart';
import 'package:tdvp/utility/config_progress.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/style.dart';

class ListsProPages extends StatefulWidget {
  const ListsProPages({
    Key? key,
  }) : super(key: key);

  @override
  State<ListsProPages> createState() => _ListsProPagesState();
}

class _ListsProPagesState extends State<ListsProPages> {
  String? idDocUser;
  bool load = true;
  bool? haveProduct;
  var stockModels = <StockModel>[];
  var idStocks = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      appBar: AppBar(
        actions: [ShowAddCart()],
        backgroundColor: StyleProjects().primaryColor,
        title: Text('สินค้า'),
      ),
      body: load
          ? const ConfigProgress()
          : haveProduct!
              ? ListView.builder(
                  itemCount: stockModels.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowListProductWhereCat(
                            idStock: idStocks[index],
                          ),
                        )),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ConfigText(lable: stockModels[index].category),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: ConfigText(
                    lable: 'ยังไม่มีสินค้า',
                    textStyle: StyleProjects().topicstyle4,
                  ),
                ),
    );
  }
}
