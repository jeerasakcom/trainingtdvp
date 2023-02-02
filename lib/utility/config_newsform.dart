import 'package:flutter/material.dart';
import 'package:tdvp/utility/config_text.dart';

class FormDetail extends StatelessWidget {
  final String lable;
  final String? Function(String?) myValidate;
  final Function(String?) mySave;
  final TextEditingController? textEditingController;
  const FormDetail({
    Key? key,
    required this.lable,
    required this.myValidate,
    required this.mySave,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: 250,
      height: 250,
      child: TextFormField(controller: textEditingController ?? TextEditingController(),
        onSaved: mySave,
        validator: myValidate,
        decoration: InputDecoration(
          label: ConfigText(lable: lable),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
