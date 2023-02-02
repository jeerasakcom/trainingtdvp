/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tdvp/components/backend/news/lists_news.dart';
import 'package:tdvp/components/backend/stock/lists_stock.dart';
import 'package:tdvp/components/frontend/guest/authentication/authentication.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/style.dart';
import 'package:tdvp/models/users_model.dart';

class AdminServices extends StatefulWidget {
  @override
  _AdminServicesState createState() => _AdminServicesState();
}

class _AdminServicesState extends State<AdminServices> {
  //String? fname, email;
  Widget currenWidget = ListsCategoryPages(
    docStock: '',
  );

  String? images;
  String? level;
  String? fname;
  String? email, password, token;

  bool load = true;
  bool? haveAdmin;
  var userModels = <UserModel>[];
  var docIdUsers = <String>[];

  @override
  void initState() {
    super.initState();
    //findUserLogin();
    findNameAnEmail();
  }

  //
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
          fname = event.displayName;
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
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            //  onPressed: () => Navigator.pushNamed(context, '/showCart'),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.home),
            // onPressed: () => Navigator.pushNamed(context, '/showOrderCustomer'),
            onPressed: () {},
          ),
        ],
      ),
      drawer: buildDrawer(),
      body: currenWidget,
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              buildUserAccountsDrawerHeader(),
/*               buildListTileAllProduct(),
              buildListTileShowMenList(),
              buildListTileShowWomenList(),
              buildListTileShowProfile(),
              buildListTileAddProduct(), */
              buildListProducts(),
              buildListPublishing(),
              buildListNews(),
            ],
          ),
          buildSignOut(),
        ],
      ),
    );
  }

  ListTile buildListTileAllProduct() {
    return ListTile(
      leading: Icon(
        Icons.home,
        //color: MyStyle().lightColor,
        size: 36.0,
      ),
      title: Text('Home'),
      subtitle: Text('Show All Product in my Stock'),
      onTap: () {
        /*  setState(() {
          currenWidget = AllProduct();
        });
        Navigator.pop(context); */
      },
    );
  }

  ListTile buildListTileShowMenList() {
    return ListTile(
      leading: Icon(
        Icons.face,
        color: Colors.blue,
        size: 36.0,
      ),
      title: Text('Product For Men'),
      subtitle: Text('Show All Product in my Stock'),
      onTap: () {
        /*  setState(() {
          currenWidget = ShowMenList();
        });
        Navigator.pop(context); */
      },
    );
  }

  ListTile buildListTileShowWomenList() {
    return ListTile(
      leading: Icon(
        Icons.face,
        color: Colors.pink,
        size: 36.0,
      ),
      title: Text('Product For Women'),
      subtitle: Text('Show All Product in my Stock'),
      onTap: () {
        /* setState(() {
          currenWidget = ShowWomenList();
        });
        Navigator.pop(context); */
      },
    );
  }

  ListTile buildListTileShowProfile() {
    return ListTile(
      leading: Icon(
        Icons.account_circle,
        size: 36.0,
      ),
      title: Text('Profile User'),
      subtitle: Text('edit Profile'),
      onTap: () {
        /* setState(() {
          currenWidget = ShowProfileUser();
        });
        Navigator.pop(context); */
      },
    );
  }

  ListTile buildListTileAddProduct() {
    return ListTile(
      leading: Icon(
        Icons.queue,
        size: 36.0,
        color: Colors.greenAccent,
      ),
      title: Text('Add Product'),
      subtitle: Text('product'),
      onTap: () {
        /* setState(() {
          currenWidget = AddListProduct();
        });
        Navigator.pop(context); */
      },
    );
  }

  //
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
        'หมวดหมู่แบบพิมพ์/แบบพิมพ์',
        style: TextStyle(
          fontFamily: 'THSarabunNew',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          //color: const Color(0xFF000120),
          color: Colors.black,
        ),
      ),
      onTap: () {
        setState(() {
          currenWidget = ListsCategoryPages(
            docStock: '',
          );
        });
        Navigator.pop(context);
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
        setState(() {
          currenWidget = ListsCategoryPages(
            docStock: '',
          );
        });
        Navigator.pop(context);
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
      /* onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = const ListsNewsPages();
        });
      }, */

      onTap: () {
        setState(() {
          currenWidget = ListsNewsPages();
        });
        Navigator.pop(context);
      },
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage('assets/images/cover20.jpg'), fit: BoxFit.cover),
      ),

      // currentAccountPicture: Image.asset('assets/images/avatar.png'),

      accountName: Row(
        children: [
          ConfigText(
            lable: 'สิทธ์การเข้าถึง : ผู้ดูแลระบบ',
            textStyle: StyleProjects().contentstyle1,
          ),
          /* StyleProjects().boxwidth1,
          StyleProjects().topicaccount(fname == null ? 'fname' : fname!), */
        ],
      ),

      accountEmail: Row(
        children: [
          ConfigText(
            lable: 'อีเมล :',
            textStyle: StyleProjects().contentstyle1,
          ),
          StyleProjects().boxwidth1,
          StyleProjects().topicaccount(email == null ? 'Email' : email!),
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

  Column buildSignOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
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
          tileColor: StyleProjects().cardStream11,
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
      ],
    );
  }
}
 */