
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tdvp/components/backend/products/list_products.dart';
import 'package:tdvp/models/products_model.dart';
import 'package:tdvp/models/stock_model.dart';
import 'package:tdvp/utility/category_constant.dart';
import 'package:tdvp/utility/dailog.dart';
import 'package:tdvp/utility/style.dart';

class CreateProductPages extends StatefulWidget {
  final StockModel stockModel;
  final String docStock;
  const CreateProductPages(
      {Key? key, required this.stockModel, required this.docStock})
      : super(key: key);

  @override
  _CreateProductPagesState createState() => _CreateProductPagesState();
}

class _CreateProductPagesState extends State<CreateProductPages> {
  StockModel? stockModel;
  String? docStock;
  File? file;
  String? id, name, price, detail, quantity, category, images;

  @override
  void initState() {
    super.initState();
    stockModel = widget.stockModel;
    docStock = widget.docStock;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleProjects().primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: height,
          child: Column(
            children: [
              StyleProjects().boxTop2,
              blockheader(),
              StyleProjects().boxheight1,
              blockproid(),
              StyleProjects().boxheight1,
              blockproname(),
              StyleProjects().boxheight1,
              blockprodetail(),
              StyleProjects().boxheight1,
              blockproprice(),
              StyleProjects().boxheight1,
              blockproquantity(),
              StyleProjects().boxheight1,
              blockImg(),
              StyleProjects().boxheight1,
              blockSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget blockheader() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          const Text(
            'เพิ่มแบบพิมพ์ใหม่',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'THSarabunNew',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xff000f3b),
            ),
          ),
        ],
      ),
    );
  }

  Widget blockproid() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'รหัสสินค้า',
                style: TextStyle(
                  fontFamily: 'THSarabunNew',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff000f3b),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 200,
                height: 35,
                child: TextField(
                  onChanged: (value) => id = value.trim(),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xff000f3b),
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget blockproname() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'ชื่อสินค้า',
                style: TextStyle(
                  fontFamily: 'THSarabunNew',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff000f3b),
                ),
              ),
            ],
          ),
          TextFormField(
            maxLines: 2,
            minLines: 1,
            onChanged: (value) => name = value.trim(),
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Color(0xff000f3b),
              )),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget blockprodetail() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'รายละเอียด',
                style: TextStyle(
                  fontFamily: 'THSarabunNew',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff000f3b),
                ),
              ),
            ],
          ),
          TextFormField(
            maxLines: 5,
            minLines: 2,
            onChanged: (value) => detail = value.trim(),
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Color(0xff000f3b),
              )),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget blockproprice() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Text(
            'ราคา',
            style: TextStyle(
              fontFamily: 'THSarabunNew',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff000f3b),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 100,
            height: 35,
            child: TextField(
              onChanged: (value) => price = value.trim(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xff000f3b),
                )),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            'บาท',
            style: TextStyle(
              fontFamily: 'THSarabunNew',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff000f3b),
            ),
          ),
        ],
      ),
    );
  }

  Widget blockproquantity() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Text(
            'จำนวน',
            style: TextStyle(
              fontFamily: 'THSarabunNew',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff000f3b),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 100,
            height: 35,
            child: TextField(
              onChanged: (value) => quantity = value.trim(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xff000f3b),
                )),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            'เล่ม',
            style: TextStyle(
              fontFamily: 'THSarabunNew',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff000f3b),
            ),
          ),
        ],
      ),
    );
  }

  Widget blockImg() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                'ภาพสินค้า',
                style: TextStyle(
                  fontFamily: 'THSarabunNew',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff000f3b),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.add_a_photo,
                  color: Color(0xff000f3b),
                ),
                onPressed: () => chooseImage(ImageSource.camera),
              ),
              SizedBox(
                width: 150,
                height: 150,
                child: file == null
                    ? Image.asset(
                        'assets/images/productsimg.png',
                      )
                    : Image.file(file!),
              ),
              IconButton(
                icon: const Icon(
                  Icons.add_photo_alternate,
                  color: Color(0xff000f3b),
                ),
                onPressed: () => chooseImage(ImageSource.gallery),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget blockSaveButton() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color(0xFF459522),
          ),
        ),
        child: Text(
          "บันทึก",
          style: StyleProjects().topicstyle3,
        ),
        onPressed: () {
          if (file == null) {
            normalDialog(context, 'กรุณาเลือก รูปภาพด้วย คะ');
          } else if (id == null ||
              id!.isEmpty ||
              name == null ||
              name!.isEmpty ||
              price == null ||
              price!.isEmpty ||
              detail == null ||
              detail!.isEmpty ||
              quantity == null ||
              quantity!.isEmpty) {
            normalDialog(context, 'กรุณากรอก ทุกช่อง คะ');
          } else {
            processUploadAndInsertData();
          }
        },
      ),
    );
  }

// img
  Future<Null> chooseImage(ImageSource imageSource) async {
    var result = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 800,
      maxHeight: 800,
    );
    file = File(result!.path);
    setState(() {});
  }

  ///db
  Future<void> processUploadAndInsertData() async {
    String nameFile = 'products${Random().nextInt(100000)}.jpg';
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference reference = firebaseStorage.ref().child('products/$nameFile');
    UploadTask uploadTask = reference.putFile(file!);
    uploadTask.whenComplete(() async {
      reference.getDownloadURL().then((value) async {
        String images = value;
        /*
        ProductModel productModel = ProductModel(
            id: int.parse(id!),
            name: name!,
            detail: detail!,
            price: int.parse(price!),
            quantity: int.parse(quantity!),
            images: images);
            */

        ProductModel model = ProductModel(
            id: int.parse(id!),
            name: name!,
            detail: detail!,
            price: int.parse(price!),
            quantity: int.parse(quantity!),
            images: images);

        Map<String, dynamic> map = model.toMap();

        FirebaseFirestore.instance
            .collection('stock')
            .doc(docStock)
            .collection('products')
            .doc()
            //.set(productModel.toMap())
            .set(map)
            .then((value) => Navigator.pop(context));
        /*
            .then((value) =>  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ListsProductsPages(),
                ),
              ),);
              */

        /*
            .then((value) async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc()
              .collection('profile')
              .get()
              .then((value) async {
            for (var item in value.docs) {
              var docIdProfile = item.id;
              Map<String, dynamic> map = {};
              map['products'] = true;
              await FirebaseFirestore.instance
                  .collection('user')
                  .doc()
                  .collection('profile')
                  .doc(docIdProfile)
                  .update(map)
                  .then((value) => Navigator.pop(context));
            }
          });
        });
      
      */
      });
    });
  }
}
