import 'package:flutter/material.dart';
import 'package:tdvp/utility/style.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: StyleProjects().backgroundState,

      body: SingleChildScrollView(
        child: Container(
          height: height,
          padding: const EdgeInsets.all(20),
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),

      //
    );
  }
}
