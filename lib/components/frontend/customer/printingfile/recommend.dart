import 'package:flutter/material.dart';
import 'package:tdvp/utility/style.dart';


class RecommendFilePrint extends StatefulWidget {
  RecommendFilePrint({Key? key}) : super(key: key);

  @override
  State<RecommendFilePrint> createState() => _RecommendFilePrintState();
}

class _RecommendFilePrintState extends State<RecommendFilePrint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: StyleProjects().darkColor,
      ),
      backgroundColor: StyleProjects().backgroundState,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StyleProjects().boxTop1,
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 1,
                color: Colors.black54,
                margin: EdgeInsets.all(25),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StyleProjects().boxTop2,
                    StyleProjects().header1(),
                    StyleProjects().boxTop2,
                    Center(
                      child: Text(
                        'คำแนะนำ',
                        style: StyleProjects().topicstyle7,
                      ),
                    ),
                    Center(
                      child: Text(
                        'สำหรับการส่งงานให้โรงพิมพ์ มีดังนี้',
                        style: StyleProjects().topicstyle7,
                      ),
                    ),

                    StyleProjects().boxheight1,

                    //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        StyleProjects().boxwidth1,
                        Text(
                          "1.ปรับโหมดสี CMYK",
                          textAlign: TextAlign.left,
                          style: StyleProjects().contentstyle6,
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        StyleProjects().boxwidth1,
                        Text(
                          "2.ตั้งความละเอียดของไฟล์",
                          textAlign: TextAlign.left,
                          style: StyleProjects().contentstyle6,
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        StyleProjects().boxwidth1,
                        Text(
                          "3.ตั้งระยะขอบและระยะตัดตก",
                          textAlign: TextAlign.left,
                          style: StyleProjects().contentstyle6,
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        StyleProjects().boxwidth1,
                        Text(
                          "4.การแปลงตัวอักษร(Font)ให้กลายเป็นวัตถุ",
                          textAlign: TextAlign.left,
                          style: StyleProjects().contentstyle6,
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        StyleProjects().boxwidth1,
                        Text(
                          "5.ฝังไฟล์รูปภาพ",
                          textAlign: TextAlign.left,
                          style: StyleProjects().contentstyle6,
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        StyleProjects().boxwidth1,
                        Text(
                          "6.ส่งผลิตด้วยไฟล์ PDF",
                          textAlign: TextAlign.left,
                          style: StyleProjects().contentstyle6,
                        ),
                      ],
                    ),



/*
                    Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(20),
                      // alignment: Alignment.topCenter,
                      child: Column(
                        ///mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StyleProjects().boxSpace2,
                          Text(
                            "1.ปรับโหมดสี CMYK",
                            textAlign: TextAlign.left,
                            style: StyleProjects().topicstyle7,
                          ),
                          StyleProjects().boxSpace2,
                          Text(
                            "2.ตั้งความละเอียดของไฟล์",
                            style: StyleProjects().topicstyle7,
                          ),
                          StyleProjects().boxSpace2,
                          Text(
                            "3.ตั้งระยะขอบและระยะตัดตก",
                            style: StyleProjects().topicstyle7,
                          ),
                          StyleProjects().boxSpace2,
                          Text(
                            "4.การแปลงตัวอักษร (Font) ให้กลายเป็นวัตถุ",
                            style: StyleProjects().topicstyle7,
                          ),
                          StyleProjects().boxSpace2,
                          Text(
                            "5.ฝังไฟล์รูปภาพ",
                            style: StyleProjects().topicstyle7,
                          ),
                          StyleProjects().boxSpace2,
                          Text(
                            "6.ส่งผลิตด้วยไฟล์ PDF",
                            style: StyleProjects().topicstyle7,
                          ),
                          StyleProjects().boxSpaceTop2,
                        ],
                      ),
                    ),
                  
                  */

                    StyleProjects().boxTop2,

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'ตกลง',
                        style: StyleProjects().topicstyle3,
                      ),
                    ),

                    StyleProjects().boxTop2,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
