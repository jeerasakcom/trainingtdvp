import 'dart:async';
import "package:dio/dio.dart";
import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tdvp/utility/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';




class CommunicationPages extends StatefulWidget {
  const CommunicationPages({super.key});

  @override
  State createState() => CommunicationPagesState();
}

class CommunicationPagesState extends State<CommunicationPages>
    with SingleTickerProviderStateMixin {
  static const LatLng centerMap = const LatLng(13.960564, 100.799599);

  Widget Map() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: const CameraPosition(
        target: centerMap,
        zoom: 15,
      ),
      onMapCreated: (GoogleMapController googleMapController) {},
      markers: TDVPMarker(),
    );
  }

  Set<Marker> TDVPMarker() {
    // ignore: prefer_collection_literals
    return <Marker>[
      const Marker(
        position: centerMap,
        markerId: MarkerId('TDVP'),
        infoWindow: InfoWindow(
          title: "โรงพิมพ์อาสารักษาดินแดนกรมการปกครอง",
          snippet: "55/1 หมู่ 11 ต.บึงทองหลาง อ.ลำลูกกา จ.ปทุมธานี 12150",
        ),
      ),
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 215, 238, 255),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                elevation: 0,
                expandedHeight: 150,
                leading: const BackButton(
                  //color: Color.fromARGB(255, 255, 255, 255),
                  color: Colors.black87,
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    "assets/images/singthong.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    indicatorColor: const Color(0xff04066b),
                    labelColor: const Color(0xff04066b),
                    unselectedLabelColor: const Color(0xff011298),
                    labelStyle: StyleProjects().topicstyle6,
                    // ignore: prefer_const_literals_to_create_immutables
                    tabs: [
                      const Tab(
                        text: "ติดต่อ/สอบถาม",
                      ),
                      const Tab(
                        text: 'โซเชียลมีเดีย',
                      ),
                      const Tab(
                        text: 'แผนที่',
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },

          //tab
          body: TabBarView(
              //controller: _tabController,
              children: [
                Container(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 10,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ListView(
                          children: <Widget>[
                            StyleProjects().boxheight1,
                            Container(
                              child: Text(
                                "ติดต่อ/สอบถาม",
                                textAlign: TextAlign.center,
                                style: StyleProjects().topicstyle1,
                              ),
                            ),
                            StyleProjects().boxheight1,

                            //
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                //color: const Color(0xfff4f8fb),
                                color: const Color(0xffd6f0ff),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Material(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        //color: const Color(0xfff4f8fb),
                                        color: const Color(0xffd6f0ff),
                                      ),
                                      child: IconButton(
                                        icon: Image.asset(
                                            'assets/images/contact.png'),
                                        onPressed: () =>
                                            launch("tel://020124170"),
                                      ),
                                    ),
                                  ),
                                  StyleProjects().boxwidth1,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'ศูนย์บริการลูกค้า (ส่วนกลาง)',
                                        textAlign: TextAlign.center,
                                        style: StyleProjects().contentstyle3,
                                      ),
                                      StyleProjects().boxheight1,
                                      Text(
                                        '0-2012-4170  ถึง  80',
                                        textAlign: TextAlign.center,
                                        style: StyleProjects().contentstyle3,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            //
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                //color: const Color(0xfff4f8fb),
                                color: const Color(
                                    0xffd6f0ff), //99daff),  //00a4ff),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              //padding: EdgeInsets.all(20),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Material(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        //color: const Color(0xfff4f8fb),
                                        color: const Color(0xffd6f0ff),
                                      ),
                                      child: IconButton(
                                        icon: Image.asset(
                                          'assets/images/contact.png',
                                        ),
                                        onPressed: () =>
                                            launch("tel://0863253414"),
                                      ),
                                    ),
                                  ),
                                  StyleProjects().boxwidth1,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'งานจำหน่าย',
                                        textAlign: TextAlign.center,
                                        style: StyleProjects().contentstyle3,
                                      ),
                                      StyleProjects().boxheight1,
                                      Text(
                                        "086-3253414",
                                        textAlign: TextAlign.center,
                                        style: StyleProjects().contentstyle3,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            //
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                //color: const Color(0xfff4f8fb),
                                color: const Color(0xffd6f0ff),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Material(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xffd6f0ff),
                                        //color: const Color(0xfff4f8fb),
                                      ),
                                      child: IconButton(
                                        icon: Image.asset(
                                          'assets/images/contact.png',
                                        ),
                                        onPressed: () =>
                                            launch("tel://0863253416"),
                                      ),
                                    ),
                                  ),
                                  StyleProjects().boxwidth1,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'งานรับงานและประเมินราคา',
                                        textAlign: TextAlign.center,
                                        style: StyleProjects().contentstyle3,
                                      ),
                                      StyleProjects().boxheight1,
                                      Text(
                                        "086-3253416",
                                        textAlign: TextAlign.center,
                                        style: StyleProjects().contentstyle3,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            //
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                //color: const Color(0xfff4f8fb),
                                color: const Color(0xffd6f0ff),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Material(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xffd6f0ff),

                                        //color: const Color(0xfff4f8fb),
                                      ),
                                      child: IconButton(
                                        icon: Image.asset(
                                          'assets/images/contact.png',
                                        ),
                                        onPressed: () =>
                                            launch("tel://0863253413"),
                                      ),
                                    ),
                                  ),
                                  StyleProjects().boxwidth1,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'งานเร่งรัดและติดตามหนี้สิน',
                                        textAlign: TextAlign.center,
                                        style: StyleProjects().contentstyle3,
                                      ),
                                      StyleProjects().boxheight1,
                                      Text(
                                        "086-3253413",
                                        textAlign: TextAlign.center,
                                        style: StyleProjects().contentstyle3,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            //
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                color: const Color(0xffd6f0ff),
                                //color: const Color(0xfff4f8fb),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Material(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xffd6f0ff),
                                        //color: const Color(0xfff4f8fb),
                                      ),
                                      child: IconButton(
                                        icon: Image.asset(
                                          'assets/images/contact.png',
                                        ),
                                        onPressed: () =>
                                            launch("tel://0863253417"),
                                      ),
                                    ),
                                  ),
                                  StyleProjects().boxwidth1,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'งานการเงิน',
                                        textAlign: TextAlign.center,
                                        style: StyleProjects().contentstyle3,
                                      ),
                                      StyleProjects().boxheight1,
                                      Text(
                                        "086-3253417",
                                        textAlign: TextAlign.center,
                                        style: StyleProjects().contentstyle3,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //2new
                Stack(
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              StyleProjects().boxTop1,
                              Text(
                                "Social Network",
                                textAlign: TextAlign.center,
                                style: StyleProjects().topicstyle2,
                              ),
                              StyleProjects().boxheight1,

                              SizedBox(
                                child: Image.asset(
                                  'assets/images/tdvpprinting20.png',
                                ),
                              ),

                              //
                              StyleProjects().boxheight1,

                              SignInButton(
                                Buttons.Facebook,
                                //mini: true,
                                onPressed: () => launch(
                                    'https://www.facebook.com/โรงพิมพ์อาสารักษาดินแดน-กรมการปกครอง-113003706735920/'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                //3
                Stack(
                  children: [
                    Container(
                      //height: 300,
                      //width: 300,
                      child: Container(
                        //padding: const EdgeInsets.all(10),
                        padding: EdgeInsets.zero,
                        child: Stack(
                          children: <Widget>[
                            SizedBox(
                              child: Map(),
                            ),
                            _tdvpbox(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}

Widget _tdvpbox() {
  return Align(
    alignment: Alignment.bottomLeft,
    child: Card(
      //color: const Color(0xffb7c0d4),
      //color: const Color(0xfffefbfb),
      //color: const Color(0xff0095da),
      //color: const Color(0xff002040),
      color: const Color(0xff1461e7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),

      //
      elevation: 5,
      //margin: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),

      //margin: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Container(
        height: 100,
        width: 280,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/b11.jpg',
                fit: BoxFit.cover,
                height: 50,
                width: 80,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    StyleProjects().boxheight1,
                    Text(
                      "โรงพิมพ์อาสารักษาดินแดน กรมการปกครอง",
                      textAlign: TextAlign.center,
                      style: StyleProjects().contentstyle2,
                    ),
                    Text(
                      "55/1 หมู่11 ต.บึงทองหลาง อ.ลำลูกกา จ.ปทุมธานี 12150",
                      textAlign: TextAlign.center,
                      style: StyleProjects().contentstyle2,
                    ),
                    Text(
                      "เวลาทำการ วันจันทร์-วันศุกร์ " "เวลา 08.00น.-17.00น.",
                      textAlign: TextAlign.center,
                      style: StyleProjects().contentstyle2,
                    ),
                    Text(
                      "โทร. 0-2012-4170 ถึง 80",
                      textAlign: TextAlign.center,
                      style: StyleProjects().contentstyle2,
                    ),
                  ],
                )),
          ],
        ),
      ),
    ),
  );
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Color.fromARGB(255, 215, 238, 255),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
