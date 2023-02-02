import 'dart:io';
import 'dart:async';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tdvp/components/frontend/guest/authentication/authentication.dart';
import 'package:tdvp/components/frontend/guest/calendar/calendarpage.dart';
import 'package:tdvp/components/frontend/guest/chatbot/chatbot.dart';
import 'package:tdvp/components/frontend/guest/communication/communication.dart';
import 'package:tdvp/components/frontend/guest/corporation/corporation.dart';
import 'package:tdvp/utility/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> _onWillPop() async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: const Color(0xffe6f8ff), //03a7dd),
              title: Text(
                'Exit',
                style: StyleProjects().alertstyle1,
              ),
              content: Text(
                'คุณต้องการออกจากแอปพลิเคชัน?',
                style: StyleProjects().alertstyle2,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
                  },
                  child: Text(
                    'ใช่',
                    style: StyleProjects().alertstyle2,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'ไม่',
                    style: StyleProjects().alertstyle2,
                  ),
                ),
              ],
            ));
  }

  List<String> nameIcons = [
    '001.png',
    '002.png',
    '003.png',
    '004.png',
    '005.png',
    '006.png',
    '007.png',
    '008.png',
    '009.png',
  ];

  List<String> titles = [
    'ข้อมูลองค์กร',
    'แบบสิ่งพิมพ์',
    'ประเมินราคา',
    'ปฏิทิน',
    'สถานะการพิมพ์',
    'การจัดส่ง',
    'ติดต่อ',
    'ข่าวสาร',
    'แชทบอท',
  ];

  List<Widget> widgets = [];

  List<Widget> routToWidgdets = [
    const CorporationPages(),
    const HomePage(),
    const HomePage(),
    const CalendarPage(),
    const HomePage(),
    const HomePage(),
    const CommunicationPages(),
    const HomePage(),
    const ChatbotPage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int i = 0;
    for (var title in titles) {
      Widget widget = createECard(title, nameIcons[i], i);
      widgets.add(widget);
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget imageSliderCarousel = Container(
      color: const Color.fromARGB(239, 0, 13, 112),
      height: 200,
      child: Carousel(
        autoplay: true,
        boxFit: BoxFit.fill,
        dotBgColor: Colors.transparent,
        dotSize: 3,
        dotColor: const Color.fromARGB(255, 0, 0, 0),
        dotIncreasedColor: const Color.fromARGB(255, 23, 23, 23),
        autoplayDuration: const Duration(seconds: 35),
        animationCurve: Curves.fastOutSlowIn,

        // ignore: prefer_const_literals_to_create_immutables
        images: [
          const AssetImage('assets/images/tdvp0010.jpg'),
          const AssetImage('assets/images/tdvp0020.jpg'),
          const AssetImage('assets/images/tdvp0030.jpg'),
          const AssetImage('assets/images/tdvp0040.jpg'),
        ],
      ),
    );

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        /*
        key: scaffoldKey,

        appBar: AppBar(
          backgroundColor: const Color(0xff81d4fa),
          title: Text(
            'โรงพิมพ์อาสารักษาดินแดน กรมการปกครอง\n'
            'Territorial Defence Volunteers Printing',
            style: StyleProjects().contentstyle5,
          ),
          leading: IconButton(
            icon: Image.asset('assets/images/logo.png'),
            onPressed: () {
              if (scaffoldKey.currentState!.isDrawerOpen) {
                scaffoldKey.currentState!.closeDrawer();
              } else {
                scaffoldKey.currentState!.openDrawer();
              }
            },
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/images/account_circle.svg",
                height: 35,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  ),
                );
              },
            ),
          ],
        ),

        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                    Color(0xff002040),
                    Color(0xff004080),
                  ]),
                ),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 75,
                        ),
                      ),
                      Text(
                        'โรงพิมพ์อาสารักษาดินแดน กรมการปกครอง\n'
                        'Territorial Defence Volunteers Printing',
                        textAlign: TextAlign.center,
                        style: StyleProjects().contentstyle6,
                      ),
                    ],
                  ),
                ),
              ),

              //1
              ListTile(
                leading: Icon(
                  Icons.login_outlined,
                  color: Color(0xff100200),
                ),
                title: Text(
                  'เข้าสู่ระบบ',
                  style: StyleProjects().topicstyle4,
                ),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePage())),
              ),

//2
              ListTile(
                leading: Icon(
                  Icons.people_alt_outlined,
                  color: Color(0xff100200),
                ),
                title: Text(
                  'สมัครสมาชิก',
                  style: StyleProjects().topicstyle4,
                ),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePage())),
              ),
            ],
          ),
        ),
*/

        appBar: AppBar(
          backgroundColor: const Color(0xff81d4fa),
          title: Text(
            'โรงพิมพ์อาสารักษาดินแดน กรมการปกครอง\n'
            'Territorial Defence Volunteers Printing',
            style: StyleProjects().contentstyle5,
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/images/account_circle.svg",
                height: 35,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthenticationPage(),
                  ),
                );
              },
            ),
          ],
          leading: IconButton(
            icon: Image.asset('assets/images/logo.png'),
            onPressed: () {},
          ),
        ),

        //
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg3.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              imageSliderCarousel,
              StyleProjects().boxheight1,
              headerPage(),
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.all(10.0),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  primary: false,
                  crossAxisCount: 3,
                  children: widgets,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createECard(String title, String nameIcon, int index) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => routToWidgdets[index],
        ),
      ),

      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //color: const Color(0xff003a9f),
        color: const Color(0xffb3e5fc),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Image.asset(
                  'assets/images/icons/$nameIcon',
                  width: 50,
                  height: 50,
                ),
              ),
              Text(
                title,
                style: StyleProjects().topicstyle6,
              ),
            ],
          ),
        ),
      ),

      //
    );
  }

  Widget headerPage() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
                //color: const Color(0xffffda7a),
                //color: const Color(0xff000f3b),
                color: Color(0xFF14005C),
              ),
            ),
          ),
          Text(
            "เมนู",
            textAlign: TextAlign.center,
            style: StyleProjects().topicstyle1,
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
                color: Color(0xFF14005C),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //
}
