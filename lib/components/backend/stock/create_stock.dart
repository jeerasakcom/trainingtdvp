import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tdvp/models/stock_model.dart';
import 'package:tdvp/utility/category_constant.dart';
import 'package:tdvp/utility/dailog.dart';
import 'package:tdvp/utility/style.dart';

class CreateCategoryPages extends StatefulWidget {
  const CreateCategoryPages({Key? key}) : super(key: key);

  @override
  _CreateCategoryPagesState createState() => _CreateCategoryPagesState();
}

class _CreateCategoryPagesState extends State<CreateCategoryPages> {
  File? file;
  String? category, images;
  String? id;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleProjects().titlebar2,
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: height,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'เพิ่มหมวดหมู่แบบพิมพ์',
                style: TextStyle(
                  fontFamily: 'THSarabunNew',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff000f3b),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              blockid(),
              blockCategory(),
              blockImg(),
              const SizedBox(
                height: 30,
              ),
              blockSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget blockImg() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
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
                        'assets/images/p22.jpg',
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

  Future<Null> chooseImage(ImageSource imageSource) async {
    var result = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 800,
      maxHeight: 800,
    );
    file = File(result!.path);
    setState(() {});
  }

  Widget blockCategory() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'หมวดสินค้า',
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
              Padding(
                padding: const EdgeInsets.all(10),
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
                      category = value;
                    });
                  },
                  hint: const Text(
                    'กรุณาเลือกหมวดสินค้าค่ะ',
                    style: TextStyle(
                      fontFamily: 'THSarabunNew',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD80000),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget blockid() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      //padding: EdgeInsets.all(20),
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

  Widget blockSaveButton() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color(0xFF459522),
          ),
        ),
        child: const Text(
          "บันทึก",
          style: TextStyle(
            fontFamily: 'THSarabunNew',
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Color(0xffffffff),
          ),
        ),
        onPressed: () {
          if (file == null) {
            normalDialog(context, 'กรุณาเลือก รูปภาพด้วย คะ');
          } else if (id == null ||
              id!.isEmpty ||
              category == null ||
              category!.isEmpty) {
            normalDialog(context, 'กรุณากรอก ทุกช่อง คะ');
          } else {
            processUploadAndInsertData();
          }
        },
      ),
    );
  }

  Future<void> processUploadAndInsertData() async {
    String nameFile = 'category${Random().nextInt(100000)}.jpg';
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference reference = firebaseStorage.ref().child('category/$nameFile');
    UploadTask uploadTask = reference.putFile(file!);
    await uploadTask.whenComplete(() async {
      await reference.getDownloadURL().then((value) async {
        String images = value;
        StockModel stockModel =
            StockModel(id: int.parse(id!), category: category!, images: images);

        await FirebaseFirestore.instance
            .collection('stock')
            .doc()
            .set(stockModel.toMap())
            .then((value) => Navigator.pop(context));
      });
    });
  }
}
