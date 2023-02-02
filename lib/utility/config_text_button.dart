import 'package:flutter/material.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/style.dart';


class ConfigTextButton extends StatelessWidget {
  final String label;
  final Function() pressFunc;

  const ConfigTextButton({
    Key? key,
    required this.label,
    required this.pressFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: pressFunc,
      child: ConfigText(
        lable: label,
        textStyle: StyleProjects().alertstyle2,
      ),
    );
  }
}
