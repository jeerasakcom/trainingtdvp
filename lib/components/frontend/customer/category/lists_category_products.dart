import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tdvp/components/frontend/customer/carts/cart.dart';
import 'package:tdvp/models/users_model.dart';
import 'package:tdvp/models/products_model.dart';
import 'package:tdvp/models/sqlite_helper.dart';
import 'package:tdvp/models/sqlite_model.dart';
import 'package:tdvp/utility/config_images_url.dart';
import 'package:tdvp/utility/config_progress.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/dailog.dart';
import 'package:tdvp/utility/style.dart';

class ListsProductWhereCategory extends StatefulWidget {
  final String idStock;

  const ListsProductWhereCategory({
    Key? key,
    required this.idStock,
  }) : super(key: key);

  @override
  State<ListsProductWhereCategory> createState() =>
      _ListsProductWhereCategoryState();
}

class _ListsProductWhereCategoryState extends State<ListsProductWhereCategory> {
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
        // backgroundColor: MyConstant.primart,
        title: Text('รายการสินค้า'),
        actions: [
          AddCartsPages(callBackFunc: () {
            print('Call Back Work');
            readAllProduct();
          }),
        ],
      ),
      /*
      body: load
          ? const ConfigProgress()
          : ListView.builder(
              itemCount: productModels.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () =>
                    dialogAddCart(productModels[index], docProducts[index]),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  color: StyleProjects().cardStream10,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /*
                        ConfigImagesUrl(
                          path: productModels[index].images,
                        ),
                        */
                        Container(
                          height: 75,
                          width: 100,
                          child: ConfigImagesUrl(
                            path: productModels[index].images,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConfigText(
                              lable: productModels[index].name,
                            ),
                            ConfigText(
                              lable:
                                  'ราคา ${productModels[index].price.toString()} บาท',
                            ),
                            ConfigText(
                              lable:
                                  'จำนวน คงเหลือ = ${productModels[index].quantity.toString()}',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
              "แบบพิมพ์",
              style: StyleProjects().topicstyle2,
            ),
            load ? ConfigProgress() : blocklistsproducts()
          ],
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
            //leading: const ConfigLogo(),
            /*
            title: ConfigText(
              lable: productModel.name,
            ),
            */
            title: Column(
              children: [
                ConfigText(
                  lable: productModel.name,
                ),
              ],
            ),
            subtitle: Column(
              children: [
                ConfigText(
                    lable: 'ราคา = ${productModel.price.toString()} บาท'),
                ConfigText(
                    lable:
                        'จำนวนคงเหลือ = ${productModel.quantity.toString()}'),
              ],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConfigImagesUrl(
                path: productModel.images,
              ),
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
                    if (value.isEmpty) {
                      processAddCart(productModel, chooseProduct, docProduct);

                      /*
                    } else {
                      if (sqliteModels[0].docUser == idDocUser) {
                        processAddCart(productModel, chooseProduct, docProduct);
                      }
                      */

                    }
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

    await SQLiteHelper().insertValueToSQLite(sqLiteModel).then(
          (value) =>
              /*
        MyDialog().normalDialog(
            context, 'เพิ่มลงตะกร้า', 'เพิ่ม ${productModel.name} สำเร็จ'));
            */
              /*  StyleDialog(context: context).normalDialog(
            title: 'เพิ่มลงตะกร้า',
            message: 'เพิ่ม ${productModel.name} สำเร็จ')); */

              MyDialog(context: context).normalDialog(
                  title: 'เพิ่มลงตะกร้า',
                  message: 'เพิ่ม ${productModel.name} สำเร็จ'),
        );
  }

  Widget blocklistsproducts() {
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
                itemCount: productModels.length,
                itemBuilder: (context, index) => Container(
                  //padding: const EdgeInsets.all(5),
                  child: InkWell(
                    onTap: () =>
                        dialogAddCart(productModels[index], docProducts[index]),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      /*
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                        color: StyleProjects().cardStream10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            /*
                            Row(
                              children: [
                                StyleProjects().boxwidth1,
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 50,
                                ),
                                StyleProjects().boxwidth1,
                                ConfigText(
                                  lable: productModels[index].name,
                                ),
                                ConfigText(
                                  lable:
                                      'ราคา ${productModels[index].price.toString()} บาท',
                                ),
                                ConfigText(
                                  lable:
                                      'จำนวน คงเหลือ = ${productModels[index].quantity.toString()}',
                                ),
                              ],
                            ),
                          
                          */

                            Row(
                              children: [
                                Container(
                                  height: 75,
                                  width: 100,
                                  child: ConfigImagesUrl(
                                    path: productModels[index].images,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConfigText(
                                      lable: productModels[index].name,
                                    ),
                                    ConfigText(
                                      lable:
                                          'ราคา ${productModels[index].price.toString()} บาท',
                                    ),
                                    ConfigText(
                                      lable:
                                          'จำนวน คงเหลือ = ${productModels[index].quantity.toString()}',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                   
                   */
                      child: Container(
                        height: 100,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                          color: StyleProjects().cardStream10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              /*
                            Row(
                              children: [
                                StyleProjects().boxwidth1,
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 50,
                                ),
                                StyleProjects().boxwidth1,
                                ConfigText(
                                  lable: productModels[index].name,
                                ),
                                ConfigText(
                                  lable:
                                      'ราคา ${productModels[index].price.toString()} บาท',
                                ),
                                ConfigText(
                                  lable:
                                      'จำนวน คงเหลือ = ${productModels[index].quantity.toString()}',
                                ),
                              ],
                            ),
                          
                          */

                              Row(
                                children: [
                                  Container(
                                    height: 75,
                                    width: 100,
                                    child: ConfigImagesUrl(
                                      path: productModels[index].images,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productModels[index].name,
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: StyleProjects().contentstyle5,
                                        //style: StyleProjects().topicstyle4,
                                      ),
                                      Text(
                                        'ราคา ${productModels[index].price.toString()} บาท',
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: StyleProjects().contentstyle5,
                                        //style: StyleProjects().topicstyle4,
                                      ),
                                      Text(
                                        'จำนวน ${productModels[index].quantity.toString()} เล่ม',
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: StyleProjects().contentstyle5,
                                        // style: StyleProjects().topicstyle4,
                                      ),

                                      /*
                                       Text(
                                        productModels[index].detail,
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: StyleProjects().contentstyle5,
                                        //style: StyleProjects().topicstyle4,
                                      ),
                                      */

                                      /*
                                      ConfigText(
                                        lable: productModels[index].detail,
                                      ),
                                      */
                                      /*
                                      ConfigText(
                                        lable:
                                            'ราคา ${productModels[index].price.toString()} บาท',
                                      ),
                                      */
                                      /*
                                      ConfigText(
                                        lable:
                                            'จำนวน ${productModels[index].quantity.toString()}',
                                      ),
                                      */
                                    ],
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
            ),
          ],
        );
      }),
    );
  }
}
