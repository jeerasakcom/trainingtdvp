import 'package:flutter/material.dart';
import 'package:tdvp/utility/config_image.dart';
import 'package:tdvp/utility/config_title.dart';
import 'package:tdvp/utility/style.dart';

class CorporationPages extends StatefulWidget {
  const CorporationPages({super.key});

  @override
  State createState() => CorporationPagesState();
}

class CorporationPagesState extends State<CorporationPages>
    with SingleTickerProviderStateMixin {
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
                expandedHeight: 175,
                leading: const BackButton(
                  color: Colors.black87,
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    "assets/images/cbg.jpg",
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
                        text: 'คณะผู้บริหาร',
                      ),
                      const Tab(
                        text: 'วิสัยทัศน์/พันธกิจ',
                      ),
                      const Tab(
                        text: 'ประวัติองค์กร',
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
                //1new
                /*
                Container(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(height: 20),
                            Column(
                              children: <Widget>[
                                Text(
                                  'คณะกรรมการบริหาร\n'
                                  'โรงพิมพ์อาสารักษาดินแดน กรมการปกครอง',
                                  textAlign: TextAlign.center,
                                  style: StyleProjects().topicstyle6,
                                ),
                              ],
                            ),

                            //
                            StyleProjects().boxheight1,
                            //1
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/images/c10.jpg',
                                        height: 100,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'นายธนาคม จงจิระ',
                                            textAlign: TextAlign.center,
                                            style:
                                                StyleProjects().contentstyle5,
                                          ),
                                          Text(
                                            'อธิบดีกรมการปกครอง',
                                            textAlign: TextAlign.center,
                                            style:
                                                StyleProjects().contentstyle5,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            //
                            StyleProjects().boxheight1,

                            //2
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/images/c9.jpg',
                                        height: 100,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'นายสมชาย เกียรติก้องแก้ว',
                                            textAlign: TextAlign.center,
                                            style:
                                                StyleProjects().contentstyle5,
                                          ),
                                          Text(
                                            'ผอ.โรงพิมพ์อาสารักษาดินแดน',
                                            textAlign: TextAlign.center,
                                            style:
                                                StyleProjects().contentstyle5,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            //

                            StyleProjects().boxheight1,

                            //3
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/images/c8-1.jpg',
                                            height: 100,
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                'ร.ท.ภัทรชัย ขันธหิรัญ',
                                                textAlign: TextAlign.center,
                                                style: StyleProjects()
                                                    .contentstyle5,
                                              ),
                                              Text(
                                                'ผช.ผอ.(ฝ่ายการค้า)',
                                                textAlign: TextAlign.center,
                                                style: StyleProjects()
                                                    .contentstyle5,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/images/c8-2.jpg',
                                            height: 100,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'นายกฤษดา โลศิริ',
                                                textAlign: TextAlign.center,
                                                style: StyleProjects()
                                                    .contentstyle5,
                                              ),
                                              Text(
                                                'ผช.ผอ.(ฝ่ายการพิมพ์)',
                                                textAlign: TextAlign.center,
                                                style: StyleProjects()
                                                    .contentstyle5,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            StyleProjects().boxheight1,

                            //4
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/images/logo2.jpg',
                                            height: 100,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'นายจงรัก เพชรเสน',
                                                textAlign: TextAlign.center,
                                                style: StyleProjects()
                                                    .contentstyle5,
                                              ),
                                              Text(
                                                'ผช.ผอ.(ฝ่ายบริหาร)',
                                                textAlign: TextAlign.center,
                                                style: StyleProjects()
                                                    .contentstyle5,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/images/c8-3.jpg',
                                            height: 100,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'นายสิทธิพร คงหอม',
                                                textAlign: TextAlign.center,
                                                style: StyleProjects()
                                                    .contentstyle5,
                                              ),
                                              Text(
                                                'ผช.ผอ.(ฝ่ายการเงินและบัญชี)',
                                                textAlign: TextAlign.center,
                                                style: StyleProjects()
                                                    .contentstyle5,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            StyleProjects().boxheight1,

                            //5
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/images/c8-4.jpg',
                                                height: 100,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    'นายอมรศักดิ์ ธีระนานนท์',
                                                    textAlign: TextAlign.center,
                                                    style: StyleProjects()
                                                        .contentstyle5,
                                                  ),
                                                  Text(
                                                    'เลขานุการคณะกรรมการฯ',
                                                    textAlign: TextAlign.center,
                                                    style: StyleProjects()
                                                        .contentstyle5,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            StyleProjects().boxheight1,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                */
                //new ceo
                Container(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10,
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: ListView(
                          children: [
/*
                  StyleProjects().header2(),
                  StyleProjects().boxheight1,
                  */
                            /*
                    
                  Text(
                    'คณะกรรมการบริหาร\n'
                    'โรงพิมพ์อาสารักษาดินแดน กรมการปกครอง',
                    textAlign: TextAlign.center,
                    style: StyleProjects().topicstyle4,
                  ),
                  */

                            const SizedBox(
                              height: 75,
                              child: ConfigImage(),
                            ),



/* 
                            const Center(
                              child: ConfigTitle(title: "คณะผู้บริหารระดับสูง"),
                            ),
                            const Center(
                              child: ConfigTitle(
                                  title:
                                      "โรงพิมพ์อาสารักษาดินแดน กรมการปกครอง"),
                            ), */

                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    "คณะผู้บริหารระดับสูง",
                                    style: StyleProjects().topicstyle4,
                                  ),
                                  Text(
                                    "โรงพิมพ์อาสารักษาดินแดน กรมการปกครอง",
                                    style: StyleProjects().topicstyle4,
                                  ),
                                ],
                              ),
                            ),

                            StyleProjects().boxheight1,

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Image(
                                  image: AssetImage('assets/images/logo.png'),
                                  height: 50,
                                ),
                                const ConfigTitle(
                                    title: "ผู้บริหารระดับสูงโรงพิมพ์ฯ"),
                              ],
                            ),

                            //1
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                //color: const Color(0xfff4f8fb),
                                //color: const Color(0xffd6f0ff),
                                color: const Color.fromARGB(255, 255, 234, 174),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Material(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        //color: const Color(0xfff4f8fb),
                                        //color: Color(0xffd6f0ff),
                                        color:
                                            Color.fromARGB(255, 255, 234, 174),
                                      ),
                                      child: const CircleAvatar(
                                        radius: 35,
                                        /*
                              backgroundImage: NetworkImage(
                                  "https://tdvpprint.com/assets/frontend/images/boss/1.jpg"),
*/
                                        backgroundImage: AssetImage(
                                          "assets/images/board/1.jpg",
                                        ),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "นายแมนรัตน์ รัตนสุคนธ์",
                                        //style: StyleProjects().topicstyle4,
                                        style: StyleProjects().contentstyle5,
                                      ),
                                      Text(
                                        "อธิบดีกรมการปกครอง",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                      Text(
                                        "ประธานคณะกรรมการดำเนินงาน",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                      Text(
                                        "โรงพิมพ์อาสารักษาดินแดน กรมการปกครอง",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            //2
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                //color: const Color(0xfff4f8fb),
                                //color: const Color(0xffd6f0ff),
                                color: const Color.fromARGB(255, 255, 234, 174),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Material(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        //color: const Color(0xfff4f8fb),
                                        //color: Color(0xffd6f0ff),
                                        color:
                                            Color.fromARGB(255, 255, 234, 174),
                                      ),
                                      child: const CircleAvatar(
                                        radius: 35,
                                        /*
                              backgroundImage: NetworkImage(
                                  "https://tdvpprint.com/assets/frontend/images/boss/2.jpg"),
                              */

                                        backgroundImage: AssetImage(
                                          "assets/images/board/2.jpg",
                                        ),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "นายสันติ ชูศรี",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                      Text(
                                        "เลขานุการคณะกรรมการฯ รพ.อส.",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                      Text(
                                        "ผู้อำนวยการ",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                      Text(
                                        "โรงพิมพ์อาสารักษาดินแดน กรมการปกครอง",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            //
                            // StyleProjects().boxTop2,
                            // const ConfigTitle(title: "ผู้ช่วยผู้อำนวยการโรงพิมพ์ฯ"),

                            StyleProjects().boxheight1,

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Image(
                                  image: AssetImage('assets/images/logo.png'),
                                  height: 50,
                                ),
                                const ConfigTitle(
                                    title: "ผู้ช่วยผู้อำนวยการโรงพิมพ์ฯ"),
                              ],
                            ),

                            //3
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                //color: const Color(0xfff4f8fb),
                                //color: const Color(0xffd6f0ff),
                                color: const Color(0xffcfe4c3),

                                //color: const Color.fromARGB(255, 255, 234, 174),
                                //color: Color.fromARGB(255, 111, 176, 255),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Material(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        //color: const Color(0xfff4f8fb),
                                        //color: Color(0xffd6f0ff),
                                        color: Color(0xffcfe4c3),
                                        //color: Color.fromARGB(255, 255, 234, 174),
                                        //color: Color.fromARGB(255, 111, 176, 255),
                                      ),
                                      child: const CircleAvatar(
                                        radius: 35,
                                        /* backgroundImage: NetworkImage(
                                  "https://tdvpprint.com/assets/frontend/images/boss/3-1.jpg"), */

                                        backgroundImage: AssetImage(
                                          "assets/images/board/3-1.jpg",
                                        ),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "เรือโท ภัทรชัย ขันธหิรัญ",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                      Text(
                                        "ผู้ช่วยผู้อำนวยการ (ฝ่ายการค้า)",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                      Text(
                                        "โรงพิมพ์อาสารักษาดินแดน กรมการปกครอง",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            //4
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                //color: const Color(0xfff4f8fb),
                                color: const Color(0xffd6f0ff),
                                // color: const Color.fromARGB(255, 255, 234, 174),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Material(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        //color: const Color(0xfff4f8fb),
                                        color: Color(0xffd6f0ff),
                                        //color: Color.fromARGB(255, 255, 234, 174),
                                      ),
                                      child: const CircleAvatar(
                                        radius: 35,
                                        /* backgroundImage: NetworkImage(
                                  "https://tdvpprint.com/assets/frontend/images/boss/3-2.jpg"),
                               */

                                        backgroundImage: AssetImage(
                                          "assets/images/board/3-2.jpg",
                                        ),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "นายเพิ่มศักดิ์ ศรีสวัสดิ์",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                      Text(
                                        "ผู้ช่วยผู้อำนวยการ (ฝ่ายการพิมพ์)",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                      Text(
                                        "โรงพิมพ์อาสารักษาดินแดน กรมการปกครอง",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            //5
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                //color: const Color(0xfff4f8fb),
                                //color: const Color(0xffd6f0ff),
                                // color: const Color.fromARGB(255, 255, 234, 174),
                                color: const Color(0xffe4c7c0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Material(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        //color: const Color(0xfff4f8fb),
                                        //color: Color(0xffd6f0ff),
                                        //color: Color.fromARGB(255, 255, 234, 174),
                                        color: Color(0xffe4c7c0),
                                      ),
                                      child: const CircleAvatar(
                                        radius: 35,
                                        /*  backgroundImage: NetworkImage(
                                  "https://tdvpprint.com/assets/frontend/images/boss/3-3.jpg"), */

                                        backgroundImage: AssetImage(
                                          "assets/images/board/3-3.jpg",
                                        ),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "นายนัฐนันท์ ศรีจันทร์",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                      Text(
                                        "ผู้ช่วยผู้อำนวยการ (ฝ่ายบริหาร)",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                      Text(
                                        "โรงพิมพ์อาสารักษาดินแดน กรมการปกครอง",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            //6
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                //color: const Color(0xfff4f8fb),
                                //color: const Color(0xffd6f0ff),
                                //color: const Color.fromARGB(255, 255, 234, 174),
                                color: const Color(0xffecd2da),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Material(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        //color: const Color(0xfff4f8fb),
                                        //color: Color(0xffd6f0ff),
                                        //color: Color.fromARGB(255, 255, 234, 174),
                                        color: Color(0xffecd2da),
                                      ),
                                      child: const CircleAvatar(
                                        radius: 35,
                                        /* backgroundImage: NetworkImage(
                                  "https://tdvpprint.com/assets/frontend/images/boss/3-4.jpg"), */

                                        backgroundImage: AssetImage(
                                          "assets/images/board/3-4.jpg",
                                        ),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "นายเอกภณ แจ่มใส",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                      Text(
                                        "ผู้ช่วยผู้อำนวยการ (ฝ่ายการเงินและบัญชี)",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                      Text(
                                        "โรงพิมพ์อาสารักษาดินแดน กรมการปกครอง",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            //7
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                //color: const Color(0xfff4f8fb),
                                //color: const Color(0xffd6f0ff),
                                color: const Color.fromARGB(255, 255, 234, 174),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Material(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        //color: const Color(0xfff4f8fb),
                                        //color: Color(0xffd6f0ff),
                                        color:
                                            Color.fromARGB(255, 255, 234, 174),
                                      ),
                                      child: const CircleAvatar(
                                        radius: 35,
                                        /* backgroundImage: NetworkImage(
                                  "https://tdvpprint.com/assets/frontend/images/boss/4.jpg"), */

                                        backgroundImage: AssetImage(
                                          "assets/images/board/4.jpg",
                                        ),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "นายบูชา จันทรพิมล",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                      Text(
                                        "ผู้ช่วยเลขานุการ",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                      Text(
                                        "คณะกรรมการดำเนินงาน",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                      Text(
                                        "โรงพิมพ์อาสารักษาดินแดน กรมการปกครอง",
                                        style: StyleProjects().contentstyle5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            //
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                //2new
                Stack(
                  children: [
                    /*
                    Container(
                      child: StyleProjects().bgdataCorp(),
                    ),
                    */
                    ListView(
                      padding: const EdgeInsets.all(20),
                      children: <Widget>[
                        StyleProjects().boxTop2,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Image(
                              image: AssetImage('assets/images/logo.png'),
                              height: 50,
                            ),
                            const ConfigTitle(title: "พันธกิจและวิสัยทัศน์"),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            color: const Color(0xff9dc98a),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),

                            //
                            elevation: 5,
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const ListTile(
                                  leading: Icon(
                                    Icons.check_circle,
                                    //color: const Color(0xff2c6cdf),
                                    color: Color(0xff369000),
                                  ),
                                  title: Text(
                                    'วิสัยทัศน์ (Vision)',
                                    style: TextStyle(
                                      fontFamily: 'THSarabunNew',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                      //color: Color(0xFF090943),
                                      color: Color(0xff900036),
                                      //color: const Color(0xff002055),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    '"ยุคใหม่ รวดเร็ว ทันสมัย ก้าวไกลสู่สากล"',
                                    style: TextStyle(
                                      fontFamily: 'THSarabunNew',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      //color: const Color(0xff900036),
                                      //color: const Color(0xff9b194a),
                                      //color: Color(0xFF090943),
                                      //color: Color(0xFF0040aa),
                                      color: Color(0xFFdd0053),
                                    ),
                                  ),
                                ),
                                /*
                              Image.asset(
                                'assets/images/cc100.jpeg',
                                height: 100,
                              ),
                              */

                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            color: const Color(0xff9dc98a),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const ListTile(
                                  leading: Icon(
                                    Icons.check_circle,
                                    //color: const Color(0xff2c6cdf),
                                    color: Color(0xff369000),
                                  ),
                                  title: Text(
                                    'พันธกิจ (Mission)',
                                    style: TextStyle(
                                      fontFamily: 'THSarabunNew',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                      //color: Color(0xFF090943),
                                      color: Color(0xff900036),
                                      //color: const Color(0xff002055),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const Text(
                                        "- ใส่ใจในลูกค้าและบริการ",
                                        style: TextStyle(
                                          fontFamily: 'THSarabunNew',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          //color: const Color(0xff900036),
                                          //color: Color(0xFF090943),
                                          color: Color(0xFFdd0053),
                                        ),
                                      ),
                                      const Text(
                                        '- ให้บริการแบบพิมพ์อย่างมีคุณภาพ',
                                        style: TextStyle(
                                          fontFamily: 'THSarabunNew',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          //color: const Color(0xff900036),
                                          //color: Color(0xFF090943),
                                          color: Color(0xFFdd0053),
                                        ),
                                      ),
                                      const Text(
                                        '- งานพิมพ์ระดับสากล',
                                        style: TextStyle(
                                          fontFamily: 'THSarabunNew',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          //color: const Color(0xff900036),
                                          //color: Color(0xFF090943),
                                          color: Color(0xFFdd0053),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*
                              Image.asset('assets/images/bg815.jpg',height: 100,),
                              */

                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                //3new
                Stack(
                  children: [
                    /*
                    Container(
                      child: StyleProjects().bgdataCorp(),
                    ),
                    */
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                              margin: const EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/images/b14.jpg',
                                fit: BoxFit.cover,
                                height: 150,
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                StyleProjects().boxheight1,
                                Center(
                                  child: Text(
                                    "ประวัติโรงพิมพ์อาสารักษาดินแดน",
                                    textAlign: TextAlign.center,
                                    style: StyleProjects().topicstyle2,
                                  ),
                                ),
                                StyleProjects().boxheight1,
                                Text(
                                  '   ในปีพ.ศ.2500 องค์การบริหารวิเทศกิจ(U.S.O.M.) ได้ให้ความช่วยเหลือในการก่อตั้งได้โอนกิจการให้กรมมหาดไทย โดยใช้ชื่อในการดำเนินกิจการเป็น “โรงพิมพ์กรมมหาดไทย” และได้เปลี่ยนชื่อเป็น “โรงพิมพ์ส่วนท้องถิ่น กรมการปกครอง” โดยมีการแต่งตั้งผู้อำนวยการคนแรกคือ นายพัฒน์ พินทุโยธิน ',
                                  style: StyleProjects().contentstyle5,
                                ),
                                Text(
                                  '   ในปีพ.ศ.2551 ได้เปลี่ยนชื่อมาใช้ “โรงพิมพ์อาสารักษาดินแดน กรมการปกครอง” จนถึงปัจจุบัน และได้ยึดถือว่าวันที่ 28 กันยายนของทุกปี เป็น "วันคล้ายวันสถาปนาของโรงพิมพ์อาสารักษาดินแดน กรมการปกครอง กระทรวงมหาดไทย"',
                                  style: StyleProjects().contentstyle5,
                                ),
                              ],
                            ),
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
      color: const Color.fromARGB(255, 215, 238, 255),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
