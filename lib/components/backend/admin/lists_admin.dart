import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tdvp/components/backend/admin/create_admin.dart';
import 'package:tdvp/models/users_model.dart';

import 'package:tdvp/utility/config_form.dart';
import 'package:tdvp/utility/config_progress.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/config_text_button.dart';
import 'package:tdvp/utility/dailog.dart';
import 'package:tdvp/utility/style.dart';

class ListsAdminPages extends StatefulWidget {
  const ListsAdminPages({
    Key? key,
  }) : super(key: key);

  @override
  State<ListsAdminPages> createState() => _ListsAdminPagesState();
}

class _ListsAdminPagesState extends State<ListsAdminPages> {
  bool load = true;
  bool? haveAdmin;
  var userModels = <UserModel>[];
  var docIdUsers = <String>[];

  @override
  void initState() {
    super.initState();
    readAdminData();
  }

  Future<void> readAdminData() async {
    if (userModels.isNotEmpty) {
      userModels.clear();
      docIdUsers.clear();
    }
    await FirebaseFirestore.instance
        .collection('users')
        .where("level", isEqualTo: "admin")
        .get()
        .then((value) {
      print('value ==> ${value.docs}');
      load = false;

      if (value.docs.isEmpty) {
        haveAdmin = false;
      } else {
        haveAdmin = true;
        for (var item in value.docs) {
          UserModel userModel = UserModel.fromMap(item.data());
          userModels.add(userModel);
          docIdUsers.add(item.id);
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
                builder: (context) => AddAdminPage(),
              )).then((value) => readAdminData());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: load
          ? const ConfigProgress()
          : haveAdmin!
              ? newContent()
              : Center(
                  child: ConfigText(
                    lable: 'ไม่มี admin',
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
              "บริหารจัดการผู้ดูแลระบบ",
              style: StyleProjects().topicstyle2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: userModels.length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    color: StyleProjects().cardStream2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                width: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "อีเมล : ${userModels[index].email}",
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: StyleProjects().contentstyle5,
                                    ),
                                    Text(
                                      "เบอร์โทร : ${userModels[index].phone}",
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: StyleProjects().contentstyle5,
                                    ),
                                  ],
                                ),
                              ),

//
                            ),
                            /*
                            Expanded(
                              flex: 1,
                              child: 
                              Row(
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
                                              message: 'คุณต้องการแก้ไข ?',
                                              label1: 'แก้ไข',
                                              label2: 'ยกเลิก',
                                              presFunc1: () {
                                                print(
                                                    '==>> ${docIdUsers[index]}');
                                                processUpdateAdmin(
                                                    docIdUsers:
                                                        docIdUsers[index]);

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
                                                      '==> ${docIdUsers[index]}');

                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('users')
                                                      .doc(docIdUsers[index])
                                                      .delete()
                                                      .then((value) {
                                                    readAdminData();
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
                            */

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color:
                                          Color.fromARGB(255, 000, 000, 000)),
                                  onPressed: () {
                                    StyleDialog(context: context).actionDialog(
                                        title: 'ยืนยันการแก้ไข',
                                        message: 'คุณต้องการแก้ไข ?',
                                        label1: 'แก้ไข',
                                        label2: 'ยกเลิก',
                                        presFunc1: () {
                                          print('==>> ${docIdUsers[index]}');
                                          processUpdateAdmin(
                                              docIdUsers: docIdUsers[index]);

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
                                                  'คุณต้องการลบ admin นี้ ?',
                                              label1: 'ลบ',
                                              label2: 'ยกเลิก',
                                              presFunc1: () async {
                                                print(
                                                    '==> ${docIdUsers[index]}');

                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(docIdUsers[index])
                                                    .delete()
                                                    .then((value) {
                                                  readAdminData();
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

  Future<void> processUpdateAdmin({required String docIdUsers}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(docIdUsers)
        .get()
        .then((value) async {
      UserModel userModel = UserModel.fromMap(value.data()!);
      TextEditingController phoneController = TextEditingController();
      phoneController.text = userModel.phone.toString();

      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: ListTile(
              title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: prefer_const_constructors
              /*
              Text(
                "ระดับ",
                style: StyleProjects().topicstyle4,
              ),
              StyleProjects().boxwidth1,

              Text(
                userModel.level.toString(),
                style: StyleProjects().topicstyle4,
              ),
              */
              Text(
                userModel.email.toString(),
                style: StyleProjects().topicstyle4,
              ),
            ],
          )),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ConfigForm2(
                    textInputType: TextInputType.number,
                    controller: phoneController,
                    label: 'เบอร์โทร',
                    iconData: Icons.phone_callback_outlined,
                    changeFunc: (String string) {}),
              ],
            ),
          ),
          actions: [
            ConfigTextButton(
              label: 'แก้ไข',
              pressFunc: () async {
                Navigator.pop(context);

                String newphone = (phoneController.text);

                Map<String, dynamic> map = userModel.toMap();

                map['phone'] = newphone;

                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(docIdUsers)
                    .update(map)
                    .then((value) {
                  readAdminData();
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
