import 'package:flutter/material.dart';

class ConfigIcon extends StatelessWidget {
  final IconData iconData;
  final Function() pressFunc;
  final Color? color;
  final double? size;

  const ConfigIcon({
    Key? key,
    required this.iconData,
    required this.pressFunc,
    this.color,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: size ?? 20,
        onPressed: pressFunc,
        icon: Icon(
          iconData,
          color: color ?? Colors.white,
          size: size ?? 20,
        ));
  }
}
