import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tdvp/components/backend/admin/lists_admin.dart';
import 'package:tdvp/components/backend/misorders/mis_orders.dart';
import 'package:tdvp/components/backend/news/lists_news.dart';
import 'package:tdvp/components/backend/products/list_products.dart';
import 'package:tdvp/components/backend/services/dashboard.dart';
import 'package:tdvp/components/backend/stock/lists_stock.dart';
import 'package:tdvp/components/frontend/guest/authentication/authentication.dart';
import 'package:tdvp/models/users_model.dart';
import 'package:tdvp/utility/config_logout.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/style.dart';

class AdminService extends StatefulWidget {
  @override
  _AdminServiceState createState() => _AdminServiceState();
}

class _AdminServiceState extends State<AdminService> {
  Widget currentWidget = const DashboardAdminPages(
    uid: '',
  );
  String? fname, email;
  var user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  bool load = true;
  bool? haveAdmin;
  var userModels = <UserModel>[];
  var docIdUsers = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //readProfile();
    readAdminData();
    findUserLogin();
  }

  Future<void> readProfile() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      setState(() {
        load = false;
        userModel = UserModel.fromMap(value.data()!);
        print('userModel ==> ${userModel!.toMap()}');
      });
    });
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
      appBar: AppBar(
        backgroundColor: StyleProjects().primaryColor,
        actions: <Widget>[
          ConfigLogout(),
          /*
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut().then((res) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthenticationPage(),
                    ),
                    (Route<dynamic> route) => false);
              });
            },
          )
        */
        ],
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  buildUserAccountsDrawerHeader(),
                  // buildListDataAdmin(),
                  buildListProducts(),
                  buildListPublishing(),
                  // buildListTransportation(),
                  // buildListPrinting(),
                  buildListNews(),
                  buildListAccount(),
                  //buildListFilePDF(),
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

  ListTile buildListDataAdmin() {
    return ListTile(
      leading: IconButton(
        icon: new Icon(
          Icons.add_chart,
          color: Colors.black,
        ),
        onPressed: () => null,
      ),
      title: const Text(
        'ผู้ดูแลระบบ',
        style: TextStyle(
          fontFamily: 'THSarabunNew',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          //color: const Color(0xFF000120),
          color: Colors.black,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget =
              /* const DashboardAdminPages(
            uid: '',
          ); */
              const ListsAdminPages();
        });
      },
    );
  }

  ListTile buildListProducts() {
    return ListTile(
      leading: IconButton(
        icon: new Icon(
          Icons.add_chart,
          color: Colors.black,
        ),
        onPressed: () => null,
      ),
      title: const Text(
        'หมวดสินค้า/รายการสินค้า',
        style: TextStyle(
          fontFamily: 'THSarabunNew',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          //color: const Color(0xFF000120),
          color: Colors.black,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = const ListsCategoryPages(
            docStock: '',
          );
        });
      },
    );
  }

  ListTile buildListPublishing() {
    return ListTile(
      leading: IconButton(
        icon: new Icon(
          //Icons.print_rounded,
          Icons.production_quantity_limits,
          color: Colors.black,
        ),
        onPressed: () => const OrdersListsPages(),
      ),
      title: const Text(
        'การสั่งซื้อ/สั่งพิมพ์',
        style: TextStyle(
          fontFamily: 'THSarabunNew',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          //color: const Color(0xFF000120),
          color: Colors.black,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = const OrdersListsPages();
        });
      },
    );
  }

  ListTile buildListNews() {
    return ListTile(
      leading: IconButton(
        icon: new Icon(
          Icons.new_label_sharp,
          color: Colors.black,
        ),
        onPressed: () => null,
      ),
      title: const Text(
        'ข่าวสาร',
        style: TextStyle(
          fontFamily: 'THSarabunNew',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          //color: const Color(0xFF000120),
          color: Colors.black,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = const ListsNewsPages();
        });
      },
    );
  }

  ListTile buildListTransportation() {
    return ListTile(
      leading: IconButton(
        icon: new Icon(
          Icons.real_estate_agent,
          color: Colors.black,
        ),
        onPressed: () => null,
      ),
      title: const Text(
        'การขนส่ง',
        style: TextStyle(
          fontFamily: 'THSarabunNew',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          //color: const Color(0xFF000120),
          color: Colors.black,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = const ListsNewsPages();
        });
      },
    );
  }

  ListTile buildListPrinting() {
    return ListTile(
      leading: IconButton(
        icon: new Icon(
          Icons.invert_colors,
          //Icons.add_task,
          color: Colors.black,
        ),
        onPressed: () => null,
      ),
      title: const Text(
        'ขั้นตอนการพิมพ์',
        style: TextStyle(
          fontFamily: 'THSarabunNew',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          //color: const Color(0xFF000120),
          color: Colors.black,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = const ListsNewsPages();
        });
      },
    );
  }

  ListTile buildListAccount() {
    return ListTile(
      leading: IconButton(
        icon: new Icon(
          Icons.add_task,
          color: Colors.black,
        ),
        onPressed: () => null,
      ),
      title: const Text(
        'รายรับ-รายจ่าย',
        style: TextStyle(
          fontFamily: 'THSarabunNew',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          //color: const Color(0xFF000120),
          color: Colors.black,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = const ListsNewsPages();
        });
      },
    );
  }

  ListTile buildListFilePDF() {
    return ListTile(
      leading: IconButton(
        icon: new Icon(
          Icons.cloud_download,
          color: Colors.black,
        ),
        onPressed: () => null,
      ),
      title: const Text(
        'ไฟล์งาน',
        style: TextStyle(
          fontFamily: 'THSarabunNew',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          //color: const Color(0xFF000120),
          color: Colors.black,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = const ListsNewsPages();
        });
      },
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: const BoxDecoration(
        image: DecorationImage(
          //image: AssetImage('assets/images/img00100.jpg'),
          //image: AssetImage('assets/images/img00100.jpg'),
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
          StyleProjects().topicaccount(fname == null ? 'คุณ' : fname!),

          /*  const Text(
            'คุณ',
            style: TextStyle(
              fontFamily: 'THSarabunNew',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              //color: const Color(0xFF000120),
              color: Color(0xFFFFFFFF),
            ),
          ),
          Text(
            "อีเมล ${userModel?.email}",
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: StyleProjects().contentstyle1,
          ),
          */ /* const SizedBox(
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
         */
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

      /* accountName:
          StyleProjects().topicaccount(fname == null ? 'คุณ' : fname!),
      accountEmail:
          StyleProjects().topicaccount(email == null ? 'อีเมล' : email!), */
    );
  }

/* UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      /* decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/wall.jpg'), fit: BoxFit.cover),
      ), */
      accountName: StyleProjects().topicaccount(fname == null ? 'คุณ' : fname!),
      accountEmail: StyleProjects().topicaccount(email == null ? 'Email' : email!),
      currentAccountPicture: Image.asset('images/logo.png'),
    );
  } */

  Column blocklogout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.red.shade700),
          child: ListTile(
            /*
            onTap: () async {
              Firebase.initializeApp().then((value) async {
                FirebaseAuth.instance
                    .signOut()
                    .then((value) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AuthenticationPage(),
                        ),
                        (route) => false));
              });
            },
            */
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
  /*
  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/b2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      currentAccountPicture: userModel == null
          ? Image.asset('assets/images/avatar.png')
          : CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(userModel.urlAvatar),
            ),

      accountName: Row(
        children: [
          Text(
            'คุณ',
            style: TextStyle(
              fontFamily: 'THSarabunNew',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              //color: const Color(0xFF000120),
              color: const Color(0xFFFFFFFF),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            userModel == null ? 'fname' : userModel.fname,
            style: TextStyle(
              fontFamily: 'THSarabunNew',
              fontSize: 20,
              fontWeight: FontWeight.normal,
              //color: const Color(0xFF000120),
              color: const Color(0xFFFFFFFF),
            ),
          ),
        ],
      ),
      accountEmail: Row(
        children: [
          Text(
            'อีเมล',
            style: TextStyle(
              fontFamily: 'THSarabunNew',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              //color: const Color(0xFF000120),
              color: const Color(0xFFFFFFFF),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            userModel == null ? 'email' : userModel.email,
            style: TextStyle(
              fontFamily: 'THSarabunNew',
              fontSize: 20,
              fontWeight: FontWeight.normal,
              //color: const Color(0xFF000120),
              color: const Color(0xFFFFFFFF),
            ),
          ),
        ],
      ),
    );
  }

*/
  //
}
