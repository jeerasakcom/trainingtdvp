import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tdvp/components/backend/stock/lists_stock.dart';
import 'package:tdvp/components/frontend/customer/dashboard/dashboardpage.dart';
import 'package:tdvp/components/frontend/customer/printingfile/recommend.dart';
import 'package:tdvp/components/frontend/customer/profile/customer_dataprofile.dart';
import 'package:tdvp/components/frontend/guest/authentication/authentication.dart';
import 'package:tdvp/models/users_model.dart';
import 'package:tdvp/utility/config_logout.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/style.dart';

class CustomerService extends StatefulWidget {
  const CustomerService({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomerServiceState createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<CustomerService> {
  UserModel? userModel;
  Widget currentWidget = const DashboardPage();

  @override
  void initState() {
    super.initState();
    findUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleProjects().primaryColor,
        // ignore: prefer_const_literals_to_create_immutables
        actions: <Widget>[
          const ConfigLogout(),

/*
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () async {
              /* FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut().then((res) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AuthenticationPage()),
                    (Route<dynamic> route) => false);
              }); */
              const ConfigLogout();
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
                  buildListProfile(),
                  buildListPublishing(),
                  buildListFilePrint(),
                  buildListHistory(),
                  buildListJobTracking(),
                  buildListTransport(),
                ],
              ),
            ),
            buildLogout(),
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
              builder: (context) => const ListsCategoryPages(docStock: '',),
              /*
              AllCategoryPages(
                idDocUser: '',
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
          MaterialPageRoute(builder: (context) => const CustomerService()),
        );
      },
    );
  }

  ListTile buildListFilePrint() {
    return ListTile(
      leading: IconButton(
        icon: new Icon(Icons.cloud_upload, color: Colors.black),
        onPressed: () => null,
      ),
      title: const Text(
        'ส่งไฟล์งาน',
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
          MaterialPageRoute(builder: (context) => RecommendFilePrint()),
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
          MaterialPageRoute(builder: (context) => const CustomerService()),
        );
      },
    );
  }

  ListTile buildListJobTracking() {
    return ListTile(
      leading: IconButton(
        icon: new Icon(Icons.invert_colors_on_outlined, color: Colors.black),
        onPressed: () => null,
      ),
      title: const Text(
        'ติดตามงานพิมพ์',
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
          MaterialPageRoute(builder: (context) => const CustomerService()),
        );
      },
    );
  }

  ListTile buildListTransport() {
    return ListTile(
      leading: IconButton(
        icon: new Icon(Icons.beenhere_outlined, color: Colors.black),
        onPressed: () => null,
      ),
      title: const Text(
        'ติดตามการจัดส่ง',
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
          MaterialPageRoute(builder: (context) => const CustomerService()),
        );
      },
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: const BoxDecoration(
        image: DecorationImage(
          //image: AssetImage('assets/images/img00100.jpg'),
          image: AssetImage('assets/images/img00100.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      currentAccountPicture: userModel == null
          ? Image.asset('assets/images/avatar.png')
          : const CircleAvatar(
              radius: 30.0,
              //backgroundImage: NetworkImage(userModel.images),
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

  Column buildLogout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.red.shade700),
          child: ListTile(
            /*
            onTap: () async {
              /* await Firebase.initializeApp().then((value) async {
                await FirebaseAuth.instance
                    .signOut()
                    .then((value) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AuthenticationPage(),
                        ),
                        (route) => false));
              }); */
               const ConfigLogout();
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
              size: 36,
              color: Colors.white,
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
          setState(() {
            /*
            userModel = UserModel.fromJson(event.data()!);
            //userModel = UserModel.fromJson(event.data());
            switch (userModel!.level) {
                case 'customer':
                  if (userModel!.level == 'customer') {
                    Navigator.pushNamedAndRemoveUntil(
                        context, StyleProjects.routeCustomer, (route) => false);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, StyleProjects.routeAdmin, (route) => false);
                  }

                  break;
                default:
              }
              */

            //
          });
        });
      });
    });
  }

  //
}
