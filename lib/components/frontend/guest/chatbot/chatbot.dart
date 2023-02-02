import 'package:flutter/material.dart';
import 'package:tdvp/utility/style.dart';




class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color(0xff004080),
        backgroundColor: StyleProjects().baseColor,
      ),
      body: Container(
        /*
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        */
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 150,
                  ),
                  
                  Padding(
                    padding: EdgeInsets.only(left:75),
                    child: headerPage(),
                  ),
                  
                  StyleProjects().boxheight1,
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/images/linebot.png',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _lineButton() {
    return InkWell(
      onTap: () {
        /*
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RegisterPage()));
            */
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        height: 50,
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff06c755),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.mail,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff06c755),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'เพิ่มเพื่อน',
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

  Widget headerPage() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/images/line.png',
            width: 50,
            height: 50,
          ),
          StyleProjects().boxwidth1,
          Text(
            "line Chatbot",
            textAlign: TextAlign.center,
            style: StyleProjects().topicstyle1,
          ),
        ],
      ),
    );
  }

  //

}
