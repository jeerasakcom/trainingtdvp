import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tdvp/components/backend/news/lists_news.dart';
import 'package:tdvp/models/news_model.dart';
import 'package:tdvp/utility/dailog.dart';
import 'package:tdvp/utility/style.dart';

class CreateNewsPages extends StatefulWidget {
  const CreateNewsPages({super.key});

  @override
  State<CreateNewsPages> createState() => _CreateNewsPagesState();
}

class _CreateNewsPagesState extends State<CreateNewsPages> {
  DateTime dateTime = DateTime.now();

  File? file;
  String? title, detail, images, newsDateTime, newstimes;
  String? showDateTime;

  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  final format = DateFormat("dd-MM-yyyy HH:mm");
  late DateTime timestamp;

  //use true
  DateTime _dueDate = DateTime.now();
  DateTime dateNow = DateTime.now();
  String _dateText = '';

  Future<Null> _selectDueDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        _dueDate = picked;
        newsDateTime = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    DateFormat dateFormat = DateFormat('dd MMM yyyy HH:mm');
    newstimes = dateFormat.format(dateTime);
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
          padding: EdgeInsets.all(20),
          height: height,
          child: Column(
            children: [
              StyleProjects().boxTop2,
              StyleProjects().header2(),
              StyleProjects().boxheight1,
              Center(
                child: Text(
                  'เพิ่มข่าวใหม่',
                  style: StyleProjects().topicstyle4,
                ),
              ),
              StyleProjects().boxheight1,
              blockdatenews(),
              //blockImages(),
              blockTitleNews(),
              blockContentsNews(),

              blockImg(),
              blockSaveNews(),
            ],
          ),
        ),
      ),
    );
  }

  //
  Widget blockdatenews() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Text(
                'วันที่ประกาศ',
                style: TextStyle(
                  fontFamily: 'THSarabunNew',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff000f3b),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () => _selectDueDate(context),
                child: Text(
                  newstimes!,
                  style: TextStyle(
                    fontFamily: 'THSarabunNew',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff000f3b),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget blockTitleNews() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      //padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'หัวข้อข่าว',
                style: TextStyle(
                  fontFamily: 'THSarabunNew',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff000f3b),
                ),
              ),
            ],
          ),
          TextFormField(
            maxLines: 2,
            minLines: 1,
            onChanged: (value) => title = value.trim(),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Color(0xff000f3b),
              )),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              /*
              hintText:
                  "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...",
            */
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

  Widget blockContentsNews() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'รายละเอียด',
                style: TextStyle(
                  fontFamily: 'THSarabunNew',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff000f3b),
                ),
              ),
            ],
          ),
          TextFormField(
            maxLines: 5,
            minLines: 2,
            onChanged: (value) => detail = value.trim(),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Color(0xff000f3b),
              )),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              /*
              hintText:
                  "Lorem Ipsum คือ เนื้อหาจำลองแบบเรียบๆ ที่ใช้กันในธุรกิจงานพิมพ์หรืองานเรียงพิมพ์ มันได้กลายมาเป็นเนื้อหาจำลองมาตรฐานของธุรกิจดังกล่าวมาตั้งแต่ศตวรรษที่ 16 เมื่อเครื่องพิมพ์โนเนมเครื่องหนึ่งนำรางตัวพิมพ์มาสลับสับตำแหน่งตัวอักษรเพื่อทำหนังสือตัวอย่าง Lorem Ipsum อยู่ยงคงกระพันมาไม่ใช่แค่เพียงห้าศตวรรษ แต่อยู่มาจนถึงยุคที่พลิกโฉมเข้าสู่งานเรียงพิมพ์ด้วยวิธีทางอิเล็กทรอนิกส์ และยังคงสภาพเดิมไว้อย่างไม่มีการเปลี่ยนแปลง มันได้รับความนิยมมากขึ้นในยุค ค.ศ. 1960 เมื่อแผ่น Letraset วางจำหน่ายโดยมีข้อความบนนั้นเป็น Lorem Ipsum และล่าสุดกว่านั้น คือเมื่อซอฟท์แวร์การทำสื่อสิ่งพิมพ์ (Desktop Publishing) อย่าง Aldus PageMaker ได้รวมเอา Lorem Ipsum เวอร์ชั่นต่างๆ เข้าไว้ในซอฟท์แวร์ด้วย",
            */
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

  Future<Null> uploadPicture() async {
    Random random = Random();
    int i = random.nextInt(100000);
    String namePic = 'news$i.jpg';

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference storageReference = firebaseStorage.ref().child('news/$namePic');
    UploadTask storageUploadTask = storageReference.putFile(file!);
    await (await storageUploadTask).ref.getDownloadURL().then((value) {
      images = value;
      print('images = $images');
      insertNews();
    });
  }

  Future<Null> insertNews() async {
    NewsModel model = NewsModel(
        title: title, detail: detail, images: images, newstimes: newstimes);

    Map<String, dynamic> map = model.toMap();

    await FirebaseFirestore.instance
        .collection('news')
        .doc()
        .set(map)
        .then((value) => Navigator.pop(context));

/*
        .then(
          (value) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ListsNewsPages(),
            ),
          ),
        );
        */
  }

  Container blockSaveNews() => Container(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color(0xFF459522),
            ),
          ),
          child: Text(
            'บันทึก',
            style: StyleProjects().topicstyle3,
          ),
          onPressed: () {
            if (file == null) {
              normalDialog(context, 'กรุณาเลือก รูปภาพด้วย คะ');
            } else if (title == null ||
                title!.isEmpty ||
                detail == null ||
                detail!.isEmpty) {
              normalDialog(context, 'กรุณากรอก ทุกช่อง คะ');
            } else {
              uploadPicture();
              //Navigator.of(context).pop();
            }
          },
        ),
      );

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var result = await ImagePicker().getImage(
        source: imageSource,
        maxWidth: 800,
        maxHeight: 800,
      );
      print('path ==>> ${result!.path}');
      setState(() {
        file = File(result.path);
      });
    } catch (e) {
      print('e ==> ${e.toString()}');
    }
  }

  Row blockImages() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(
            Icons.add_a_photo,
            color: Color(0xff000f3b),
            size: 35,
          ),
          onPressed: () => chooseImage(ImageSource.camera),
        ),
        SizedBox(
          width: 150,
          height: 150,
          child: file == null
              ? Image.asset(
                  'assets/images/newspic002.jpg',
                )
              : Image.file(file!),
        ),
        IconButton(
          icon: const Icon(
            Icons.add_photo_alternate,
            color: Color(0xff000f3b),
            size: 35,
          ),
          onPressed: () => chooseImage(ImageSource.gallery),
        ),
      ],
    );
  }

  Widget blockImg() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'ภาพข่าว',
                style: TextStyle(
                  fontFamily: 'THSarabunNew',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff000f3b),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add_a_photo,
                  color: const Color(0xff000f3b),
                ),
                onPressed: () => chooseImage(ImageSource.camera),
              ),
              Container(
                width: 150,
                height: 150,
                child: file == null
                    ? Image.asset(
                        'assets/images/newspic002.jpg',
                      )
                    : Image.file(file!),
              ),
              IconButton(
                icon: Icon(
                  Icons.add_photo_alternate,
                  color: const Color(0xff000f3b),
                ),
                onPressed: () => chooseImage(ImageSource.gallery),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
