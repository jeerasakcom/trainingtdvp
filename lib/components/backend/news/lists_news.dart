import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tdvp/models/news_model.dart';
import 'package:tdvp/components/backend/news/create_news.dart';
import 'package:tdvp/utility/config_form.dart';
import 'package:tdvp/utility/config_progress.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/config_text_button.dart';
import 'package:tdvp/utility/dailog.dart';
import 'package:tdvp/utility/style.dart';

class ListsNewsPages extends StatefulWidget {
  const ListsNewsPages({
    Key? key,
  }) : super(key: key);

  @override
  State<ListsNewsPages> createState() => _ListsNewsPagesState();
}

class _ListsNewsPagesState extends State<ListsNewsPages> {
  bool load = true;
  bool? haveNews;
  var newsModels = <NewsModel>[];
  var docIdNews = <String>[];

  @override
  void initState() {
    super.initState();
    readNewsData();
  }

  Future<void> readNewsData() async {
    if (newsModels.isNotEmpty) {
      newsModels.clear();
      docIdNews.clear();
    }
    //await
     FirebaseFirestore.instance
        .collection('news')
        .orderBy('newstimes', descending: true)
        .get()
        .then((value) {
      print('value ==> ${value.docs}');
      load = false;

      if (value.docs.isEmpty) {
        haveNews = false;
      } else {
        haveNews = true;
        for (var item in value.docs) {
          NewsModel newsModel = NewsModel.fromMap(item.data());
          newsModels.add(newsModel);
          docIdNews.add(item.id);
        }
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*
      appBar: AppBar(
        backgroundColor: StyleProjects().primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      */
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 110, 244),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateNewsPages(),
              )).then((value) => readNewsData());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: load
          ? const ConfigProgress()
          : haveNews!
              ? newContent()
              : Center(
                  child: ConfigText(
                    lable: 'ไม่มีข่าว',
                    textStyle: StyleProjects().topicstyle4,
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
            StyleProjects().boxTop2,
            StyleProjects().header2(),
            //StyleProjects().boxTop2,
            StyleProjects().boxheight1,
            Text(
              "บริหารจัดการข่าวสาร",
              style: StyleProjects().topicstyle2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: newsModels.length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 1,
                    color: StyleProjects().cardStream2,
                    //color: const Color(0xffff9c7a),
                    //color: const Color(0xFFBEE3C1),
                    // Color.fromARGB(255, 136, 223, 161),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            /*
                            Expanded(
                              flex: 1,
                              child: Image.network(
                                newsModels[index].images!,
                                width: 80,
                                height: 100,
                              ),
                            ),
                            */
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                width: 150,
                                height: 120,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${newsModels[index].title}",
                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: StyleProjects().contentstyle5,
                                    ),
                                    ConfigText(
                                      lable:
                                          "วันที่ ${newsModels[index].newstimes.toString()}",
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
                                                  'คุณต้องการแก้ไขข่าวนี้ ?',
                                              label1: 'แก้ไข',
                                              label2: 'ยกเลิก',
                                              presFunc1: () {
                                                print(
                                                    '==>> ${docIdNews[index]}');
                                                processEditNews(
                                                    docIdNews:
                                                        docIdNews[index]);

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
                                                    'คุณต้องการลบข่าวนี้ ?',
                                                label1: 'ลบ',
                                                label2: 'ยกเลิก',
                                                presFunc1: () async {
                                                  print(
                                                      '==> ${docIdNews[index]}');

                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('news')
                                                      .doc(docIdNews[index])
                                                      .delete()
                                                      .then((value) {
                                                    readNewsData();
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

  Future<void> processEditNews({required String docIdNews}) async {
    await FirebaseFirestore.instance
        .collection('news')
        .doc(docIdNews)
        .get()
        .then((value) async {
      NewsModel newsModel = NewsModel.fromMap(value.data()!);
      TextEditingController titleController = TextEditingController();
      TextEditingController detailController = TextEditingController();
      titleController.text = newsModel.title.toString();
      detailController.text = newsModel.detail.toString();

      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: ListTile(
              title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: prefer_const_constructors
              Text(
                "วันที่",
                style: StyleProjects().topicstyle4,
              ),
              StyleProjects().boxwidth1,

              Text(
                newsModel.newstimes.toString(),
                style: StyleProjects().topicstyle4,
              ),
            ],
          )),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ConfigForm2(
                    textInputType: TextInputType.text,
                    controller: titleController,
                    label: 'หัวข้อข่าว',
                    iconData: Icons.list_outlined,
                    changeFunc: (String string) {}),
                StyleProjects().boxheight1,
                ConfigForm2(
                    textInputType: TextInputType.text,
                    controller: detailController,
                    label: 'รายละเอียด',
                    iconData: Icons.list_outlined,
                    changeFunc: (String string) {}),
              ],
            ),
          ),
          actions: [
            ConfigTextButton(
              label: 'แก้ไข',
              pressFunc: () async {
                Navigator.pop(context);
                String newTitle = (titleController.text);
                String newDetail = (detailController.text);

                Map<String, dynamic> map = newsModel.toMap();

                map['title'] = newTitle;
                map['detail'] = newDetail;

                await FirebaseFirestore.instance
                    .collection('news')
                    .doc(docIdNews)
                    .update(map)
                    .then((value) {
                  readNewsData();
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
