import 'package:flutter/material.dart';
import 'package:tdvp/utility/config_icon.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/style.dart';

class ConfigForm extends StatelessWidget {
  final double? width;
  final String label;
  final IconData iconData;
  final Function(String) changeFunc;
  final bool? obscub;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final Function()? pressFunc;
  final Color? colorTheme;
  final Widget? prefixWidget;
  final Color? colorSuffixIcon;
  final double? topMargin;
  const ConfigForm({
    Key? key,
    this.width,
    required this.label,
    required this.iconData,
    required this.changeFunc,
    this.obscub,
    this.textInputType,
    this.controller,
    this.pressFunc,
    this.colorTheme,
    this.prefixWidget,
    this.colorSuffixIcon,
    this.topMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: topMargin ?? 5),
      width: width ?? 250,
      height: 100,
      child: TextFormField(
        maxLines: 10,
        minLines: 5,
        controller: controller,
        keyboardType: textInputType ?? TextInputType.text,
        style: colorTheme == null
            ? StyleProjects().contentstyle5
            : StyleProjects().contentstyle5,
        obscureText: obscub ?? false,
        onChanged: changeFunc,
        decoration: InputDecoration(
          prefixIcon: prefixWidget,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          prefix: ConfigIcon(
            color: colorSuffixIcon ?? colorTheme ?? Colors.black,
            iconData: iconData,
            pressFunc: pressFunc ?? () {},
          ),
          label: ConfigText(
            lable: label,
            textStyle: colorTheme == null
                ? StyleProjects().contentstyle5
                : StyleProjects().contentstyle5,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: colorTheme ?? StyleProjects().lightColor),
            borderRadius: colorTheme == null
                ? BorderRadius.circular(5)
                : BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 255, 14, 98)),
            //BorderSide(color: StyleProjects().lightColor),
            borderRadius: colorTheme == null
                ? BorderRadius.circular(5)
                : BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}

class ConfigForm2 extends StatelessWidget {
  final double? width;
  final String label;
  final IconData iconData;
  final Function(String) changeFunc;
  final bool? obscub;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final Function()? pressFunc;
  final Color? colorTheme;
  final Widget? prefixWidget;
  final Color? colorSuffixIcon;
  final double? topMargin;
  const ConfigForm2({
    Key? key,
    this.width,
    required this.label,
    required this.iconData,
    required this.changeFunc,
    this.obscub,
    this.textInputType,
    this.controller,
    this.pressFunc,
    this.colorTheme,
    this.prefixWidget,
    this.colorSuffixIcon,
    this.topMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: topMargin ?? 5),
      width: width ?? 250,
      height: 100,
      child: TextFormField(
        maxLines: 10,
        minLines: 2,
        controller: controller,
        keyboardType: textInputType ?? TextInputType.text,
        style: colorTheme == null
            ? StyleProjects().contentstyle5
            : StyleProjects().contentstyle5,
        obscureText: obscub ?? false,
        onChanged: changeFunc,
        decoration: InputDecoration(
          prefixIcon: prefixWidget,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          prefix: ConfigIcon(
            color: colorSuffixIcon ?? colorTheme ?? Colors.black,
            iconData: iconData,
            pressFunc: pressFunc ?? () {},
          ),
          label: ConfigText(
            lable: label,
            textStyle: colorTheme == null
                ? StyleProjects().contentstyle5
                : StyleProjects().contentstyle5,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: colorTheme ?? StyleProjects().lightColor),
            borderRadius: colorTheme == null
                ? BorderRadius.circular(5)
                : BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 255, 14, 98)),
            //BorderSide(color: StyleProjects().lightColor),
            borderRadius: colorTheme == null
                ? BorderRadius.circular(5)
                : BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
