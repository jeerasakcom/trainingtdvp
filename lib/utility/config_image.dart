import 'package:flutter/material.dart';

class ConfigImage extends StatelessWidget {
  final String? path;
  final double? width;
  const ConfigImage({
    Key? key,
    this.path,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path ?? 'assets/images/logo.png',
      width: width ?? 125,
    );
  }
}
