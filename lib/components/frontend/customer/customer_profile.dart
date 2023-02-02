











import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomerProfilePage extends StatelessWidget {
  CustomerProfilePage({required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut().then((res) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPages()),
                    (Route<dynamic> route) => false);
              });
            },
          )
        ],
      ),
      */
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        thickness: 2,
                        color: const Color(0xff0d569f),
                      ),
                    ),
                  ),
                  Text(
                    "แก้ไขข้อมูลส่วนตัว",
                    style: TextStyle(
                      fontFamily: 'TH Sarabun New',
                      fontSize: 20,
                      color: const Color(0xff0d569f),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        thickness: 2,
                        color: const Color(0xff0d569f),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            /*
              new Container(
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Home() ));
                      },
                      child : Card(
                        shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                        elevation: 4,
                        color: const Color(0xffb3e5fc),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/002.png',
                              height: 75,
                            ),
                            SizedBox(width: 20,),
                            Text(
                              'แบบสิ่งพิมพ์',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'TH Sarabun New',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff04066b),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              ),

               */
          ],
        ),
      ),
      //drawer: NavigateDrawer(uid: this.uid)
    );
  }
}

/*
class NavigateDrawer extends StatefulWidget {
  final String uid;
  NavigateDrawer({Key key, this.uid}) : super(key: key);
  @override
  _NavigateDrawerState createState() => _NavigateDrawerState();
}

class _NavigateDrawerState extends State<NavigateDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: Row(
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage("assets/images/gen.jpg"),
                  backgroundColor: Colors.blueGrey,
                ),
              ],
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
                FutureBuilder(
                    future: FirebaseDatabase.instance
                        .reference()
                        .child("Users")
                        .child(widget.uid)
                        .once(),
                    builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data.value['fname'],
                          style: TextStyle(
                            fontFamily: 'THSarabunNew',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            //color: const Color(0xFF000120),
                            color: const Color(0xFFFFFFFF),
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ],
            ),
            accountEmail: Row(
              children: [
                Text(
                  'อีเมล์',
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
                FutureBuilder(
                    future: FirebaseDatabase.instance
                        .reference()
                        .child("Users")
                        .child(widget.uid)
                        .once(),
                    builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data.value['email'],
                          style: TextStyle(
                            fontFamily: 'THSarabunNew',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            //color: const Color(0xFF000120),
                            color: const Color(0xFFFFFFFF),
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ],
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/pro901.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.home, color: Colors.black),
              onPressed: () => null,
            ),
            title: Text('Home'),
            onTap: () {
              print(widget.uid);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomerServicePage(uid: widget.uid)),
              );
            },
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.assignment_ind, color: Colors.black),
              onPressed: () => null,
            ),
            title: Text('แก้ไขข้อมูลส่วนตัว'),
            onTap: () {
              print(widget.uid);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomerProfilePage(uid: widget.uid)),
              );
            },
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.shopping_cart_outlined, color: Colors.black),
              onPressed: () => null,
            ),
            title: Text('สั่งซื้อ/สั่งพิมพ์แบบพิมพ์'),
            onTap: () {
              print(widget.uid);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CustomerPublishingPage(uid: widget.uid)),
              );
            },
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.description_outlined, color: Colors.black),
              onPressed: () => null,
            ),
            title: Text('ประวัติการสั่งซื้อ/สั่งพิมพ์'),
            onTap: () {
              print(widget.uid);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CustomerOrderHistoryPage(uid: widget.uid)),
              );
            },
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.invert_colors_on_outlined,
                  color: Colors.black),
              onPressed: () => null,
            ),
            title: Text('ติดตามงานพิมพ์'),
            onTap: () {
              print(widget.uid);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CustomerJobTrackingPage(uid: widget.uid)),
              );
            },
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.beenhere_outlined, color: Colors.black),
              onPressed: () => null,
            ),
            title: Text('ติดตามการจัดส่ง'),
            onTap: () {
              print(widget.uid);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CustomerTransportationPage(uid: widget.uid)),
              );
            },
          ),
          new Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              onPressed: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((res) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPages()),
                      (Route<dynamic> route) => false);
                });
              },
            ),
            title: Text('ออกจากระบบ'),
            onTap: () {
              print(widget.uid);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPages()),
              );
            },
          ),
        ],
      ),
    );
  }
}

*/
