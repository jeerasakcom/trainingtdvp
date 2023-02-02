import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tdvp/models/users_model.dart';
import 'package:tdvp/utility/config_form.dart';
import 'package:tdvp/utility/config_progress.dart';
import 'package:tdvp/utility/config_text_button.dart';
import 'package:tdvp/utility/config_title.dart';
import 'package:tdvp/utility/dailog.dart';
import 'package:tdvp/utility/style.dart';

class UpdateProfileCustomer extends StatefulWidget {
  final String? docIdProfile;
  const UpdateProfileCustomer({Key? key, this.docIdProfile}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UpdateProfileCustomerState createState() => _UpdateProfileCustomerState();
}

class _UpdateProfileCustomerState extends State<UpdateProfileCustomer> {
  UserModel? userModel;

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController subdistrictController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController zipcodController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> map = {};
  String? docIdProfile;

  @override
  void initState() {
    super.initState();
    docIdProfile = widget.docIdProfile;
    readCurrentProfile();
  }

  Future<void> readCurrentProfile() async {
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      //await
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var item in value.docs) {
          setState(() {
            userModel = UserModel.fromMap(item.data());
            fnameController.text = userModel!.fname!;
            lnameController.text = userModel!.lname!;
            addressController.text = userModel!.address!;
            subdistrictController.text = userModel!.subdistrict!;
            districtController.text = userModel!.district!;
            provinceController.text = userModel!.province!;
            zipcodController.text = userModel!.zipcode!;
            phoneController.text = userModel!.phone!;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleProjects().primaryColor,
        //  title: const Text('แก้ไขข้อมูลส่วนบุคคล'),
      ),

      /*
      body: userModel == null
          ? const ConfigProgress()
          : GestureDetector(
              onTap: () =>
                  FocusScope.of(context).requestFocus(FocusScopeNode()),
              behavior: HitTestBehavior.opaque,
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      ConfigForm2(
                          textInputType: TextInputType.text,
                          controller: fnameController,
                          label: 'ชื่อ',
                          iconData: Icons.location_history_rounded,
                          changeFunc: (String string) {}),
                      ConfigForm2(
                          textInputType: TextInputType.text,
                          controller: lnameController,
                          label: 'นามสกุล',
                          iconData: Icons.location_history_rounded,
                          changeFunc: (String string) {}),
                      ConfigForm2(
                          textInputType: TextInputType.text,
                          controller: addressController,
                          label: 'ที่อยู่ :',
                          iconData: Icons.home,
                          changeFunc: (String string) {}),
                      ConfigForm2(
                          textInputType: TextInputType.text,
                          controller: subdistrictController,
                          label: 'ตำบล :',
                          iconData: Icons.home,
                          changeFunc: (String string) {}),
                      ConfigForm2(
                          textInputType: TextInputType.text,
                          controller: districtController,
                          label: 'อำเภอ :',
                          iconData: Icons.home,
                          changeFunc: (String string) {}),
                      ConfigForm2(
                          textInputType: TextInputType.number,
                          controller: provinceController,
                          label: 'จังหวัด :',
                          iconData: Icons.location_city_sharp,
                          changeFunc: (String string) {}),
                      ConfigForm2(
                          textInputType: TextInputType.text,
                          controller: zipcodController,
                          label: 'รหัสไปรษณีย์ :',
                          iconData: Icons.location_on_sharp,
                          changeFunc: (String string) {}),
                      ConfigForm2(
                          textInputType: TextInputType.number,
                          controller: phoneController,
                          label: 'เบอร์โทรศัพท์ :',
                          iconData: Icons.phone_android_outlined,
                          changeFunc: (String string) {}),
                      ButtonUpdateProcess(),
                    ],
                  ),
                ),
              ),
            ),
    


    */
      body: SingleChildScrollView(
        child: Column(
          children: [
            StyleProjects().boxTop1,
            Text(
              "แก้ไขข้อมูลส่วนบุคคล",
              style: StyleProjects().topicstyle2,
            ),
            StyleProjects().boxheight1,
            userModel == null
                ? const ConfigProgress()
                : GestureDetector(
                    onTap: () =>
                        FocusScope.of(context).requestFocus(FocusScopeNode()),
                    behavior: HitTestBehavior.opaque,
                    child: Center(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            ConfigForm2(
                                textInputType: TextInputType.text,
                                controller: fnameController,
                                label: 'ชื่อ',
                                iconData: Icons.location_history_rounded,
                                changeFunc: (String string) {}),
                            ConfigForm2(
                                textInputType: TextInputType.text,
                                controller: lnameController,
                                label: 'นามสกุล',
                                iconData: Icons.location_history_rounded,
                                changeFunc: (String string) {}),
                            ConfigForm2(
                                textInputType: TextInputType.text,
                                controller: addressController,
                                label: 'ที่อยู่ :',
                                iconData: Icons.home,
                                changeFunc: (String string) {}),
                            ConfigForm2(
                                textInputType: TextInputType.text,
                                controller: subdistrictController,
                                label: 'ตำบล :',
                                iconData: Icons.home,
                                changeFunc: (String string) {}),
                            ConfigForm2(
                                textInputType: TextInputType.text,
                                controller: districtController,
                                label: 'อำเภอ :',
                                iconData: Icons.home,
                                changeFunc: (String string) {}),
                            ConfigForm2(
                                textInputType: TextInputType.number,
                                controller: provinceController,
                                label: 'จังหวัด :',
                                iconData: Icons.location_city_sharp,
                                changeFunc: (String string) {}),
                            ConfigForm2(
                                textInputType: TextInputType.text,
                                controller: zipcodController,
                                label: 'รหัสไปรษณีย์ :',
                                iconData: Icons.location_on_sharp,
                                changeFunc: (String string) {}),
                            ConfigForm2(
                                textInputType: TextInputType.number,
                                controller: phoneController,
                                label: 'เบอร์โทรศัพท์ :',
                                iconData: Icons.phone_android_outlined,
                                changeFunc: (String string) {}),
                            ButtonUpdateProcess(),
                            // blockUpdateButton(),
                          ],
                        ),
                      ),
                    ),
                  ),
            StyleProjects().boxTop1,
          ],
        ),
      ),
    );
  }

  SizedBox ButtonUpdateProcess() {
    return SizedBox(
      height: 50,
      width: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () async {
          FirebaseAuth.instance.authStateChanges().listen(
            (event) async {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(event!.uid)
                  .update(map)
                  .then((value) => Navigator.pop(context))
                  .catchError((value) {
                print('@@ error ==>> $value');
              });
            },
          );

          /*
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            print('@@ map ==> $map');

            if (map.isEmpty) {
              normalDialog(context, 'ไม่มีการเปลี่ยนแปลงค่ะ');
            } else {
              FirebaseAuth.instance.authStateChanges().listen(
                (event) async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(event!.uid)
                      .update(map)
                      .then((value) => Navigator.pop(context))
                      .catchError((value) {
                    print('@@ error ==>> $value');
                  });
                },
              );
            }
          }
          */
        },
        child: Text(
          'บันทึก',
          style: StyleProjects().topicstyle3,
        ),
      ),
    );
  }

//

  Container blockUpdateButton() => Container(
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            'บันทึก',
            style: StyleProjects().topicstyle3,
          ),
          //onPressed: () {},
          onPressed: () async {
            FirebaseAuth.instance.authStateChanges().listen(
              (event) async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(event!.uid)
                    .update(map)
                    .then((value) => Navigator.pop(context))
                    .catchError((value) {
                  print('@@ error ==>> $value');
                });
              },
            );
          },
        ),
      );

/*
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

*/
//

}
