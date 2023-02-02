import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tdvp/components/frontend/guest/authentication/authentication.dart';
import 'package:tdvp/utility/config_text.dart';
import 'package:tdvp/utility/style.dart';

class ConfigLogout extends StatefulWidget {
  const ConfigLogout({Key? key}) : super(key: key);

  @override
  _ConfigLogoutState createState() => _ConfigLogoutState();
}

class _ConfigLogoutState extends State<ConfigLogout> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: ConfigText(
              lable: 'Exit',
              textStyle: StyleProjects().alertstyle1,
            ),
            content: ConfigText(
              lable: 'คุณต้องการออกจากระบบ ?',
              textStyle: StyleProjects().alertstyle2,
            ),
            actions: [
              TextButton(
                //onPressed: () => Navigator.pop(context),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AuthenticationPage()));
                },

                child: Text(
                  'ใช่',
                  style: StyleProjects().alertstyle2,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'ไม่',
                  style: StyleProjects().alertstyle2,
                ),
              ),
            ],
          ),
        );
      },
      icon: const Icon(Icons.exit_to_app),
    );
  }
}
