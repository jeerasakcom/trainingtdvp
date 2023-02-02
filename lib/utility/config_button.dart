import 'package:flutter/material.dart';
import 'package:tdvp/utility/style.dart';

class ConfigButton extends StatelessWidget {
  final String label;
  final Function() pressFunc;
  final double? opacity;
  const ConfigButton({
    Key? key,
    required this.label,
    required this.pressFunc,
    this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: StyleProjects().primaryColor.withOpacity(opacity ?? 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        onPressed: pressFunc,
        child: Text(label),
      ),
    );
  }
}
