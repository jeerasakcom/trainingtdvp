import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tdvp/components/frontend/customer/carts/cart.dart';





class DetailProductsPages extends StatefulWidget {
  const DetailProductsPages({super.key});

  @override
  State<DetailProductsPages> createState() => _DetailProductsPagesState();
}

class _DetailProductsPagesState extends State<DetailProductsPages> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
       appBar: AppBar(
        // backgroundColor: MyConstant.primart,
        title: Text('รายการสินค้า'),
        actions: [
          AddCartsPages(callBackFunc: () {
            print('Call Back Work');
           // readAllProduct();
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/p21.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            height: height,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  height: 200,
                ),


              ],
            )),
      ),
    );
  }
}
