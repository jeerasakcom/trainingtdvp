import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tdvp/components/frontend/customer/dashboard/dashboardpage.dart';
import 'package:tdvp/components/frontend/customer/orders/history_orders.dart';
import 'package:tdvp/components/frontend/customer/profile/customer_dataprofile.dart';
import 'package:tdvp/components/frontend/guest/authentication/authentication.dart';
import 'package:tdvp/components/frontend/products/lists_category.dart';
import 'package:tdvp/models/users_model.dart';
import 'package:tdvp/utility/config_logout.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/style.dart';

class CustomerService extends StatefulWidget {
  @override
  _CustomerServiceState createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<CustomerService> {
  UserModel? userModel;
  Widget currentWidget = DashboardPage();
  String? fname;
  String? email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findNameAnEmail();
    findUserLogin();
  }

  Future<Null> findToken(String uid) async {
    await Firebase.initializeApp().then((value) async {
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      await firebaseMessaging.getToken().then((value) async {
        print('### uid ที่ login อยู่ ==>> $uid');
        print('### token ==> $value');

        Map<String, dynamic> data = Map();
        //Map<String, dynamic> data = {};
        data['token'] = value;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update(data)
            .then((value) => print('Update Token Success'));
      });
    });
  }

  Future<Null> findNameAnEmail() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        String uid = event!.uid;
        findToken(uid);
        setState(() {
          //fname = event.displayName;
          email = event.email;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleProjects().primaryColor,
        // ignore: prefer_const_literals_to_create_immutables
        actions: <Widget>[
          const ConfigLogout(),
        ],
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  buildUserAccountsDrawerHeader(),
                  buildListProfile(),
                  buildListPublishing(),
                  buildListHistory(),
                ],
              ),
            ),
            blocklogout(),
          ],
        ),
      ),
      body: currentWidget,
    );
  }

  ListTile buildListProfile() {
    return ListTile(
      leading: IconButton(
        icon: new Icon(Icons.assignment_ind, color: Colors.black),
        onPressed: () => null,
      ),
      title: const Text(
        'แก้ไขข้อมูลส่วนตัว',
        style: TextStyle(
          fontFamily: 'THSarabunNew',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          //color: const Color(0xFF000120),
          color: Colors.black,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CustomerReaderProfilePage(),
          ),
        );
      },
    );
  }

  ListTile buildListPublishing() {
    return ListTile(
      leading: IconButton(
        icon: new Icon(Icons.shopping_cart_outlined, color: Colors.black),
        //onPressed: () => null,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ListsProPages(),
              /* AllCategoryPages(
                idDocUser: '',
              ), */
              /*
               ListsCategoryPages(
                docStock: '',
              ),
              */
            ),
          );
        },
      ),
      title: const Text(
        'สั่งซื้อ/สั่งพิมพ์แบบพิมพ์',
        style: TextStyle(
          fontFamily: 'THSarabunNew',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          //color: const Color(0xFF000120),
          color: Colors.black,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ListsProPages(),
          ),
          /*

          MaterialPageRoute(
            builder: (context) => ListsCategoryPages(
              docStock: '',

            ),
          ),
          */
        );
      },
    );
  }

  ListTile buildListHistory() {
    return ListTile(
      leading: IconButton(
        icon: new Icon(Icons.description_outlined, color: Colors.black),
        onPressed: () => null,
      ),
      title: const Text(
        'ประวัติการสั่งซื้อ/สั่งพิมพ์',
        style: TextStyle(
          fontFamily: 'THSarabunNew',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          //color: const Color(0xFF000120),
          color: Colors.black,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HistoryOrdersPages()),
        );
      },
    );
  }

  /*  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/pro901.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      currentAccountPicture: userModel == null
          ? Image.asset('assets/images/avatar.png')
          : const CircleAvatar(
              radius: 30.0,

              //backgroundImage: NetworkImage(userModel.images),
              /*
              backgroundImage:
                    NetworkImage("${snapshot.data.hitsList[index].images}"),
                backgroundColor: Colors.transparent,
              */

              //backgroundImage: NetworkImage('images'),
              backgroundColor: Colors.transparent,
            ),
      accountName: Row(
        children: [
          const Text(
            'คุณ',
            style: TextStyle(
              fontFamily: 'THSarabunNew',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              //color: const Color(0xFF000120),
              color: Color(0xFFFFFFFF),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            'fname',
            style: TextStyle(
              fontFamily: 'THSarabunNew',
              fontSize: 20,
              fontWeight: FontWeight.normal,
              //color: const Color(0xFF000120),
              color: Color(0xFFFFFFFF),
            ),
          ),
        ],
      ),
      accountEmail: Row(
        children: [
          const Text(
            'อีเมล',
            style: TextStyle(
              fontFamily: 'THSarabunNew',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              //color: const Color(0xFF000120),
              color: Color(0xFFFFFFFF),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            'email',
            style: TextStyle(
              fontFamily: 'THSarabunNew',
              fontSize: 20,
              fontWeight: FontWeight.normal,
              //color: const Color(0xFF000120),
              color: Color(0xFFFFFFFF),
            ),
          ),
        ],
      ),
    );
  }

  */
  Column blocklogout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.red.shade700),
          child: ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: ConfigText(
                    lable: 'Exit',
                    textStyle: StyleProjects().alertstyle1,
                  ),
                  content: ConfigText(
                    lable: 'คุณต้องการออกจากระบบ ?',
                    textStyle: StyleProjects().alertstyle2,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AuthenticationPage()));
                      },
                      child: Text(
                        'ใช่',
                        style: StyleProjects().alertstyle2,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'ไม่',
                        style: StyleProjects().alertstyle2,
                      ),
                    ),
                  ],
                ),
              );
            },
            leading: const Icon(
              Icons.exit_to_app,
              color: Color.fromARGB(255, 253, 253, 253),
            ),
            title: const Text(
              'ออกจากระบบ',
              style: TextStyle(
                fontFamily: 'THSarabunNew',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<Null> findUserLogin() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        String uid = event!.uid;
        print('uid ===>> $uid');
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .snapshots()
            .listen((event) {
          setState(() {});
        });
      });
    });
  }

  //
  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage('assets/images/pro901.jpg'), fit: BoxFit.cover),
      ),

      /*   currentAccountPicture: userModel == null
          ? Image.asset('assets/images/avatar.png')
          : const CircleAvatar(
              radius: 30.0,

              //backgroundImage: NetworkImage(userModel.images),
              
/*               backgroundImage:
                    NetworkImage("${snapshot.data.hitsList[index].images}"),
                backgroundColor: Colors.transparent, */
              

              /* backgroundImage: NetworkImage('images'),
              backgroundColor: Colors.transparent, */
            ), */

      accountName: Row(
        children: [
          /* ConfigText(
            lable: 'คุณ',
            textStyle: StyleProjects().contentstyle1,
          ),
          StyleProjects().boxwidth1,
          StyleProjects().topicaccount(fname == null ? 'fname' : fname!), */
        ],
      ),

      accountEmail: Row(
        children: [
          ConfigText(
            lable: 'อีเมล',
            textStyle: StyleProjects().contentstyle7,
          ),
          StyleProjects().boxwidth2,
          StyleProjects().topicaccount2(email == null ? 'email' : email!),
          /*  Text(
            "อีเมล : ${userModels[index].email}",
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: StyleProjects().contentstyle5,
          ), */
        ],
      ),
    );
  }

  //
}
