import 'package:flutter/material.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/style.dart';

class ConfigTitle extends StatelessWidget {
  final String title;

  const ConfigTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: ConfigText(
        lable: title,
        textStyle: StyleProjects().topicstyle4,
      ),
    );
  }
}
