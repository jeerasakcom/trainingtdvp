import 'package:flutter/material.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/style.dart';

class ConfigProgress extends StatelessWidget {
  const ConfigProgress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(
          color: Color(0xff041f78),
        ),
        StyleProjects().boxTop2,
        // ignore: prefer_const_constructors
        ConfigText(
          lable: 'กรุณารอสักครู่นะคะ...',
          textStyle: StyleProjects().topicstyle4,
        )
      ],
    ));
  }
}
