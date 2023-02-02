import 'package:flutter/material.dart';

class StyleProjects {
  // base color
  Color titlebar1 = const Color(0xff012044);
  Color titlebar2 = const Color(0xff003D9E);
  Color darkColor = const Color(0xff0659b4);
  Color primaryColor = const Color(0xff1461e7);
  Color baseColor = const Color(0xff104db8);
  Color backgroundState = const Color.fromARGB(255, 0, 52, 163);
  Color lightColor = const Color.fromARGB(255, 80, 156, 255);
  Color buttona = const Color.fromARGB(255, 130, 201, 255);
  Color buttonb = const Color(0xffe6f8ff);
  Color cardcolor = const Color(0xffb3e5fc);
  Color alertblock = const Color.fromARGB(255, 255, 222, 222);
  Color cardStream1 = const Color(0xffea7d7d);
  Color cardStream2 = const Color(0xffff9c7a);
  Color cardStream3 = const Color(0xffff7647);
  Color cardStream4 = const Color(0xffe9452b);
  Color cardStream5 = const Color(0xffe9792b);
  Color cardStream6 = const Color(0xffa11902);
  Color cardStream7 = Color.fromARGB(255, 182, 45, 21);
  Color cardStream8 = Color(0xffe71461);
  Color cardStream9 = Color(0xfff0578f);
  Color cardStream10 = Color(0xffee407f);
  Color cardStream11 = Color.fromARGB(255, 255, 23, 23);

  // Route
  static String routeHome = '/home';
  static String routAuthen = '/authen';

  // img
  static String logo = 'assets/images/logo.png';

  static String avatar = 'assets/images/avatar.png';

  // Topic
  TextStyle topicstyle1 = const TextStyle(
      fontFamily: 'THSarabunNew',
      color: Color(0xff002080),
      fontWeight: FontWeight.bold,
      fontSize: 32);

  TextStyle topicstyle2 = const TextStyle(
      fontFamily: 'THSarabunNew',
      color: Color(0xff002080),
      fontWeight: FontWeight.bold,
      fontSize: 24);

  TextStyle topicstyle3 = const TextStyle(
      fontFamily: 'THSarabunNew',
      color: Color(0xfffefbfb),
      fontWeight: FontWeight.bold,
      fontSize: 24);

  TextStyle topicstyle4 = const TextStyle(
      fontFamily: 'THSarabunNew',
      color: Color(0xff000000),
      fontWeight: FontWeight.bold,
      fontSize: 24);

  TextStyle topicstyle5 = const TextStyle(
      fontFamily: 'Charmonman',
      color: Color(0xff04066b),
      fontWeight: FontWeight.bold,
      fontSize: 20);

  TextStyle topicstyle6 = const TextStyle(
      fontFamily: 'THSarabunNew',
      color: Color(0xff002080),
      fontWeight: FontWeight.bold,
      fontSize: 18);

  TextStyle topicstyle7 = const TextStyle(
    fontFamily: 'THSarabunNew',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color(0xffffda7a),
  );

  TextStyle topicstyle8 = const TextStyle(
      fontFamily: 'THSarabunNew',
      color: Color(0xff000000),
      fontWeight: FontWeight.bold,
      fontSize: 18);

  // Content
  TextStyle contentstyle1 = const TextStyle(
      fontFamily: 'THSarabunNew',
      color: Color(0xfffefbfb),
      fontWeight: FontWeight.bold,
      fontSize: 18);

  TextStyle contentstyle2 = const TextStyle(
      fontFamily: 'THSarabunNew',
      color: Color(0xfffefbfb),
      fontWeight: FontWeight.bold,
      fontSize: 10);

  TextStyle contentstyle3 = const TextStyle(
      fontFamily: 'Charmonman',
      color: Color(0xff002080),
      fontWeight: FontWeight.bold,
      fontSize: 18);

  TextStyle contentstyle4 = const TextStyle(
    fontFamily: 'THSarabunNew',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color(0xFF14005C),
  );

  TextStyle contentstyle5 = const TextStyle(
    fontFamily: 'THSarabunNew',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color(0xFF140010),
  );

  TextStyle contentstyle6 = const TextStyle(
    fontFamily: 'THSarabunNew',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color(0xffffda7a),
  );

   TextStyle contentstyle7 = const TextStyle(
    fontFamily: 'THSarabunNew',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color(0xffa5ecd9),
  );


  // Box
  SizedBox boxTop1 = const SizedBox(
    height: 50,
  );

  SizedBox boxTop2 = const SizedBox(
    height: 30,
  );

  SizedBox boxheight1 = const SizedBox(
    height: 10,
  );

  SizedBox boxheight2 = const SizedBox(
    height: 5,
  );

  SizedBox boxwidth1 = const SizedBox(
    width: 10,
  );

   SizedBox boxwidth2 = const SizedBox(
    width: 5,
  );

  // banner
  Container header1() {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Image(
            image: AssetImage('assets/images/logo.png'),
          ),
          StyleProjects().boxwidth1,
          const Center(
            child: Text(
              'โรงพิมพ์อาสารักษาดินแดน กรมการปกครอง\n'
              'Territorial Defence Volunteers Printing',
              style: TextStyle(
                fontFamily: 'THSarabunNew',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xffffda7a),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container header2() {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Image(
            image: AssetImage('assets/images/logo.png'),
          ),
          StyleProjects().boxwidth1,
          Center(
            child: Text(
              'โรงพิมพ์อาสารักษาดินแดน กรมการปกครอง\n'
              'Territorial Defence Volunteers Printing',
              style: StyleProjects().contentstyle4,
            ),
          ),
        ],
      ),
    );
  }

  Container header3() {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Image(
            image: AssetImage('assets/images/logo.png'),
          ),
          StyleProjects().boxwidth1,
          const Center(
            child: Text(
              'โรงพิมพ์อาสารักษาดินแดน กรมการปกครอง\n'
              'Territorial Defence Volunteers Printing',
              style: TextStyle(
                fontFamily: 'THSarabunNew',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xffffda7a),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // alert
  TextStyle alertstyle1 = const TextStyle(
    fontFamily: 'THSarabunNew',
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Color(0xFFE20057),
  );

  TextStyle alertstyle2 = const TextStyle(
    fontFamily: 'THSarabunNew',
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Color(0xff000f3b),
  );

  TextStyle alertstyle3 = const TextStyle(
    fontFamily: 'THSarabunNew',
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Color(0xFFFC0022),
  );

  Widget topicaccount(String string) => Text(
        string,
        style: const TextStyle(
            fontFamily: 'THSarabunNew',
            color: Color(0xfffefbfb),
            fontWeight: FontWeight.bold,
            fontSize: 20),
      );

  Widget topicaccount2(String string) => Text(
        string,
        style: const TextStyle(
            fontFamily: 'THSarabunNew',
            color: Color(0xffa5ecd9),
            fontWeight: FontWeight.bold,
            fontSize: 20),
      );

  StyleProjects();
}
