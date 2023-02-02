import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tdvp/components/frontend/guest/authentication/authentication.dart';
import 'package:tdvp/models/users_model.dart';
import 'package:tdvp/utility/config_title.dart';
import 'package:tdvp/utility/dailog.dart';
import 'package:tdvp/utility/style.dart';

class RegisterPages extends StatefulWidget {
  @override
  _RegisterPagesState createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
  bool statusRedEye = true;
  File? file;
  String? level = 'customer';
  String? images,
      fname,
      lname,
      address,
      subdistrict,
      district,
      province,
      zipcode,
      phone,
      email,
      password,
      rePassword,
      token;

  @override
  void initState() {
    super.initState();
    findToken();
  }

  Future<void> findToken() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      token = value;
      print('token = $token');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg400.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              StyleProjects().boxTop2,
              _backButton(),
              StyleProjects().boxTop2,
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 1,
                color: Colors.black54,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    StyleProjects().boxTop1,
                    StyleProjects().header1(),
                    StyleProjects().boxTop2,
                    Center(
                      child: Text(
                        "สมัครสมาชิก",
                        style: StyleProjects().topicstyle7,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: blockAvartar(),
                    ),
                    StyleProjects().boxTop2,
                    blockfname(),
                    blocklname(),
                    blockaddress(),
                    blocksubdistrict(),
                    blockdistrict(),
                    blockprovince(),
                    blockzipcode(),
                    blockphone(),
                    blockemail(),
                    blockpassword(),
                    blockRegisterPages(),
                    StyleProjects().boxTop2,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row blockAvartar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () => chooseAvatar(ImageSource.camera),
        ),
        Container(
          width: 115,
          height: 115,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: file == null
                ? Image.asset('assets/images/avatar.png')
                : CircleAvatar(
                    backgroundImage: FileImage(file!),
                  ),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.add_photo_alternate,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () => chooseAvatar(ImageSource.gallery),
        ),
      ],
    );
  }

  Container blockfname() => Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: 250,
        child: TextField(
          onChanged: (value) => fname = value.trim(),
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(
              Icons.location_history_rounded,
              color: Colors.white,
            ),
            labelText: "ชื่อ : ",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 255, 14, 98))),
          ),
        ),
      );

  Container blocklname() => Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: 250,
        child: TextField(
          onChanged: (value) => lname = value.trim(),
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.location_history_rounded,
              color: Colors.white,
            ),
            labelText: "นามสกุล : ",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 255, 14, 98))),
          ),
        ),
      );

  Container blockaddress() => Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: 250,
        child: TextField(
          onChanged: (value) => address = value.trim(),
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            labelText: "ที่อยู่ :",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 255, 14, 98))),
          ),
        ),
      );

  Container blocksubdistrict() => Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: 250,
        child: TextField(
          onChanged: (value) => subdistrict = value.trim(),
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            labelText: "ตำบล : ",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 255, 14, 98))),
          ),
        ),
      );

  Container blockdistrict() => Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: 250,
        child: TextField(
          onChanged: (value) => district = value.trim(),
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            labelText: "อำเภอ : ",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 255, 14, 98))),
          ),
        ),
      );

  Container blockprovince() => Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: 250,
        child: TextField(
          onChanged: (value) => province = value.trim(),
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.location_city_sharp,
              color: Colors.white,
            ),
            labelText: "จังหวัด : ",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 255, 14, 98))),
          ),
        ),
      );

  Container blockzipcode() => Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: 250,
        child: TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) => zipcode = value.trim(),
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(
              Icons.location_on_sharp,
              color: Colors.white,
            ),
            labelText: "รหัสไปรษณีย์ : ",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 255, 14, 98))),
          ),
        ),
      );

  Container blockphone() => Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: 250,
        child: TextField(
          keyboardType: TextInputType.phone,
          onChanged: (value) => phone = value.trim(),
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(
              Icons.phone_android_outlined,
              color: Colors.white,
            ),
            labelText: "เบอร์โทรศัพท์ : ",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 255, 14, 98))),
          ),
        ),
      );

  Container blockemail() => Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: 250,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => email = value.trim(),
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.email_outlined,
              color: Colors.white,
            ),
            labelText: "Email :",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 255, 14, 98))),
          ),
        ),
      );

  Container blockpassword() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: 250,
      child: TextField(
        style: const TextStyle(color: Colors.white),
        onChanged: (value) => password = value.trim(),
        obscureText: statusRedEye,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: statusRedEye
                ? const Icon(Icons.remove_red_eye, color: Colors.white)
                : const Icon(Icons.remove_red_eye_outlined,
                    color: Colors.white),
            onPressed: () {
              setState(() {
                statusRedEye = !statusRedEye;
              });
              if (kDebugMode) {
                print('statusRedEye =$statusRedEye');
              }
            },
          ),
          hintStyle: const TextStyle(color: Colors.white),
          hintText: 'Password :',
          prefixIcon: const Icon(
            Icons.lock,
            color: Colors.white,
          ),
          labelText: "Password :",
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.white,
          )),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 255, 14, 98))),
        ),
      ),
    );
  }

  Future<Null> chooseAvatar(ImageSource source) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      print('path ==>> ${result!.path}');
      setState(() {
        file = File(result.path);
      });
    } catch (e) {
      print('e chooseAvatar ==> ${e.toString()}');
    }
  }

  Future<Null> authenToFirebase() async {
    await Firebase.initializeApp().then(
      (value) async {
        print('Initial Success');
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!)
            .then((value) {
          String uid = value.user!.uid;
          uploadAvatarToFirebase(uid);
        }).catchError((value) {
          String error = value.message;
          normalDialog(context, error);
        });
      },
    );
  }

  Future uploadAvatarToFirebase(String uid) async {
    String nameAvatar = '$uid.jpg';
    String images = await (await FirebaseStorage.instance
            .ref()
            .child('Avatar/$nameAvatar')
            .putFile(file!))
        .ref
        .getDownloadURL();
    print('images = $images');
    insertDataToCloudFirestore(images, uid);
  }

  Future<Null> insertDataToCloudFirestore(String images, String uid) async {
    UserModel model = UserModel(
        fname: fname,
        lname: lname,
        level: level,
        address: address,
        subdistrict: subdistrict,
        district: district,
        province: province,
        zipcode: zipcode,
        phone: phone,
        email: email,
        password: password,
        images: images,
        token: token);

    Map<String, dynamic> map = model.toMap();

    await FirebaseFirestore.instance.collection('users').doc(uid).set(map).then(
        (value) => Navigator.push(context,
            MaterialPageRoute(builder: (context) => AuthenticationPage())));
  }

  Container blockRegisterPages() => Container(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'ลงทะเบียน',
            style: StyleProjects().contentstyle5,
          ),
          onPressed: () {
            if (file == null) {
              normalDialog(context, 'กรุณาเลือก รูปภาพด้วย คะ');
            } else if (fname == null ||
                fname!.isEmpty ||
                lname == null ||
                lname!.isEmpty ||
                address == null ||
                address!.isEmpty ||
                subdistrict == null ||
                subdistrict!.isEmpty ||
                district == null ||
                district!.isEmpty ||
                province == null ||
                province!.isEmpty ||
                zipcode == null ||
                zipcode!.isEmpty ||
                phone == null ||
                phone!.isEmpty ||
                email == null ||
                email!.isEmpty ||
                password == null ||
                password!.isEmpty) {
              normalDialog(context, 'กรุณากรอก ทุกช่อง คะ');
            } else {
              print(
                  'fname = $fname, lname = $lname, level=$level, address = $address, subdistrict = $subdistrict, district = $district, province = $province, zipcode = $zipcode, phone = $phone, email = $email, password = $password');
              authenToFirebase();
            }
          },
        ),
      );

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(
                Icons.keyboard_arrow_left,
                color: Color(0xffffda7a),
              ),
            ),
            const Text(
              'Back',
              style: TextStyle(
                fontFamily: 'TH Sarabun New',
                fontSize: 18,
                color: Color(0xffffda7a),
              ),
            )
          ],
        ),
      ),
    );
  }
}
