import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tdvp/components/backend/services/services.dart';
import 'package:tdvp/components/frontend/customer/service/services.dart';
import 'package:tdvp/components/frontend/guest/home/homepage.dart';
import 'package:tdvp/components/frontend/guest/register/register.dart';
import 'package:tdvp/models/users_model.dart';
import 'package:tdvp/utility/dailog.dart';
import 'package:tdvp/utility/style.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  late double screen;
  bool statusRedEye = true;
  String? email, password;

  void routeToService(Widget widget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => widget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/p21.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          height: height,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30),
              _backButton(),
              const SizedBox(height: 10),
              Card(
                margin: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 1,
                color: Colors.black54,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    StyleProjects().boxTop2,
                    StyleProjects().header3(),
                    StyleProjects().boxTop2,
                    blockheaderLogin(),
                    blockEmail(),
                    blockPassword(),
                    StyleProjects().boxheight1,
                    blockButtonLogin(),
                    StyleProjects().boxTop2,
                    _regpath(),
                    _mailButton(),
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

  TextButton blockButtonNewAcc() => TextButton(
        onPressed: () => Navigator.pushNamed(context, '/register'),
        child: Text(
          'สมัครสมาชิก',
          style: StyleProjects().topicstyle3,
        ),
      );

  Container blockButtonLogin() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 40,
      width: 250,
      margin: const EdgeInsets.only(top: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          if ((email?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            normalDialog(context, 'กรุณากรอก ทุกช่อง คะ');
          } else {
            checkAuthenticationPage();
          }
        },
        child: Text(
          'เข้าสู่ระบบ',
          style: StyleProjects().topicstyle3,
        ),
      ),
    );
  }

  Container blockEmail() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white70,
      ),
      margin: const EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) => email = value.trim(),
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.white),
          hintText: 'Email',
          prefixIcon: const Icon(
            Icons.email_outlined,
            color: Colors.white,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 255, 14, 98),
            ),
          ),
        ),
      ),
    );
  }

  Container blockPassword() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white70,
      ),
      margin: const EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: statusRedEye,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: statusRedEye
                ? const Icon(Icons.remove_red_eye)
                : const Icon(Icons.remove_red_eye_outlined),
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
          hintText: 'Password',
          prefixIcon: const Icon(
            Icons.lock_outline,
            color: Colors.white,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 255, 14, 98),
            ),
          ),
        ),
      ),
    );
  }

  Widget blockheaderLogin() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          const Text(
            'ลงชื่อเข้าสู่ระบบ',
            textAlign: TextAlign.center,
            style: TextStyle(
              //fontFamily: 'THSarabunNew',
              fontFamily: 'Charmonman',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD5E7FF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _regpath() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 2,
                color: Color(0xfff1f8ff),
              ),
            ),
          ),
          const Text(
            'หรือ',
            style: TextStyle(
              fontFamily: 'THSarabunNew',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              //color: const Color(0xff0e254e),
              color: Color(0xffffffff),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 2,
                color: Color(0xfff1f8ff),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

//
  Widget _mailButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterPages()));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 40,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xffde3e26),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                // ignore: prefer_const_constructors
                child: Icon(
                  Icons.mail,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xffe37969),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'สมัครสมาชิกด้วยบัญชี Email',
                  style: TextStyle(
                    fontFamily: 'THSarabunNew',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Color(0xfff1f8ff),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(
                Icons.keyboard_arrow_left,
                color: Color(0xffffc52e),
              ),
            ),
            const Text(
              'Back',
              style: TextStyle(
                fontFamily: 'THSarabunNew',
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xffffc52e),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Null> checkAuthenticationPage() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((value) async {
        FirebaseFirestore.instance
            .collection('users')
            .doc(value.user!.uid)
            .snapshots()
            .listen((event) {
          UserModel model = UserModel.fromMap(event.data()!);
          switch (model.level) {
            case 'customer':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerService(),
                ),
              );
              break;
            case 'admin':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminService(),
                ),
              );
              break;
            default:
          }
        });
      }).catchError(
        (value) => normalDialog(
          context,
          value.code,
        ),
      );
    });
  }
}
