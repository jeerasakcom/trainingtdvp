import 'package:flutter/material.dart';
import 'package:tdvp/utility/style.dart';

class ConfigAvatar extends StatelessWidget {
  final String urlImage;
  final double? size;
  const ConfigAvatar({
    Key? key,
    required this.urlImage,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size ?? 35,
      backgroundImage: NetworkImage(urlImage),
      backgroundColor: StyleProjects().backgroundState,
    );
  }
}


/*
class ConfigCircleAvatar extends StatelessWidget {
  final String path;
  final double? radius;
  const ConfigCircleAvatar({
    Key? key,
    required this.path,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75,
      height: 75,
      child: CircleAvatar(radius: radius ?? 75,
        backgroundImage: NetworkImage(path),
      ),
    );
  }
}
*/