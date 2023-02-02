import 'package:flutter/material.dart';
import 'package:tdvp/utility/style.dart';


class ConfigIconButton extends StatelessWidget {
  final IconData iconData;
  final Function() pressFunc;

  const ConfigIconButton({
    Key? key,
    required this.iconData,
    required this.pressFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: pressFunc,
      icon: Icon(
        iconData,
        color: StyleProjects().darkColor,
        size: 36,
      ),
    );
  }
}
