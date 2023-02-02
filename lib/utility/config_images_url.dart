import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tdvp/utility/config_logo.dart';
import 'package:tdvp/utility/config_progress.dart';



class ConfigImagesUrl extends StatelessWidget {
  final String path;
  const ConfigImagesUrl({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CachedNetworkImage(
          imageUrl: path,
          errorWidget: (BuildContext context, String string, dynamic) =>
              const ConfigLogo(),
          placeholder: (BuildContext context, String string) =>
              const ConfigProgress(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
