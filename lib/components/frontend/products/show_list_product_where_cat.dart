import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tdvp/components/frontend/products/show_add_cart.dart';
import 'package:tdvp/models/products_model.dart';
import 'package:tdvp/models/sqlite_helper.dart';
import 'package:tdvp/models/sqlite_model.dart';
import 'package:tdvp/utility/config_progress.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/dailog.dart';
import 'package:tdvp/utility/style.dart';

class ShowListProductWhereCat extends StatefulWidget {
  final String idStock;
  const ShowListProductWhereCat({
    Key? key,
    required this.idStock,
  }) : super(key: key);

  @override
  State<ShowListProductWhereCat> createState() =>
      _ShowListProductWhereCatState();
}

class _ShowListProductWhereCatState extends State<ShowListProductWhereCat> {
  String? idStock, idDocUser;
  var productModels = <ProductModel>[];
  var docProducts = <String>[];
  bool load = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idStock = widget.idStock;
    print('idStock ==>> $idStock');
    readAllProduct();
  }

  Future<void> readAllProduct() async {
    await FirebaseFirestore.instance
        .collection('stock')
        .doc(idStock)
        .collection('products')
        .get()
        .then((value) {
      for (var item in value.docs) {
        ProductModel productModel = ProductModel.fromMap(item.data());
        productModels.add(productModel);
        docProducts.add(item.id);
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
        backgroundColor: StyleProjects().primaryColor,
        title: Text('รายการสินค้า'),
        actions: [
          ShowAddCart(callBackFunc: () {
            print('Call Back Work');
            readAllProduct();
          }),
        ],
      ),
      body: load
          ? const ConfigProgress()
          : ListView.builder(
              itemCount: productModels.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () =>
                    dialogAddCart(productModels[index], docProducts[index]),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                              flex: 1,
                              child: Container(
                                width: 50,
                                height: 100,
                                margin: const EdgeInsets.all(10),
                                child: Image.network(
                                  productModels[index].images,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ConfigText(
                              lable: productModels[index].name,
                              textStyle: StyleProjects().topicstyle4,
                            ),
                            ConfigText(
                              lable:
                                  'ราคา ${productModels[index].price.toString()} บาท',
                              textStyle: StyleProjects().topicstyle4,
                            ),
                            ConfigText(
                              lable:
                                  'คงเหลือ ${productModels[index].quantity.toString()} เล่ม',
                              textStyle: StyleProjects().topicstyle4,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> dialogAddCart(
      ProductModel productModel, String docProduct) async {
    int chooseProduct = 1;
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: ListTile(
            //leading: const ShowLogo(),
            /* title: ShowText(
              title: productModel.nameProduct,
              textStyle: MyConstant().h2Style(),
            ), */
            title: ConfigText(
              lable: productModel.name,
              textStyle: StyleProjects().topicstyle4,
            ),
            subtitle: Column(
              children: [
                ConfigText(
                  lable: 'ราคา ${productModel.price.toString()} บาท',
                  textStyle: StyleProjects().topicstyle4,
                ),
                ConfigText(
                  lable:
                      'จำนวนคงเหลือ ${productModel.quantity.toString()} เล่ม',
                  textStyle: StyleProjects().topicstyle4,
                ),
              ],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        if (chooseProduct < productModel.quantity) {
                          chooseProduct++;
                          print('chooseProduct ==>> $chooseProduct');
                        }
                        setState(() {});
                      },
                      icon: const Icon(Icons.add_circle)),
                  ConfigText(
                    lable: '$chooseProduct',
                    textStyle: StyleProjects().topicstyle4,
                  ),
                  IconButton(
                      onPressed: () {
                        if (chooseProduct > 1) {
                          chooseProduct--;
                        }
                        setState(() {});
                      },
                      icon: const Icon(Icons.remove_circle)),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  Navigator.pop(context);

                  await SQLiteHelper().readAllData().then((value) {
                    var sqliteModels = <SQLiteModel>[];
                    sqliteModels = value;
                    processAddCart(productModel, chooseProduct, docProduct);
                  });
                },
                child: const Text('เพิ่มลงตะกร้า')),
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('ยกเลิก')),
          ],
        );
      }),
    );
  }

  Future<void> processAddCart(
      ProductModel productModel, int chooseProduct, String docProduct) async {
    print('add ==> ${productModel.name} chooseProduct ==> $chooseProduct');

    SQLiteModel sqLiteModel = SQLiteModel(
      productname: productModel.name,
      price: productModel.price.toString(),
      quantity: chooseProduct.toString(),
      sum: (productModel.price * chooseProduct).toString(),
      docProduct: docProduct,
      docStock: idStock!,
      //docUser: idDocUser!
    );

/*
    await SQLiteHelper().insertValueToSQLite(sqLiteModel).then((value) =>
        MyDialog().normalDialog(context, 'เพิ่มลงตะกร้า',
            'เพิ่ม ${productModel.name} สำเร็จ'));
 
 */

/*
    await SQLiteHelper().insertValueToSQLite(sqLiteModel).then((value) =>
        MyDialog(context: context).normalDialog(
            title: 'เพิ่มลงตะกร้า',
            message: 'เพิ่ม ${productModel.name} สำเร็จ'));
            */
    await SQLiteHelper().insertValueToSQLite(sqLiteModel).then(
        (value) => normalDialog(context, 'เพิ่ม ${productModel.name} สำเร็จ'));

    //
  }
}
