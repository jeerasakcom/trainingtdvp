import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tdvp/models/products_model.dart';
import 'package:tdvp/utility/config_progress.dart';


class SearchAllProduct extends StatefulWidget {
  const SearchAllProduct({Key? key}) : super(key: key);

  @override
  _SearchAllProductState createState() => _SearchAllProductState();
}

class _SearchAllProductState extends State<SearchAllProduct> {
  List<ProductModel> productModels = [];
  List<ProductModel> searchProductModels = [];

  final debouncer = Debouncer(millisecond: 100);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // readAllProduct();
    delayTime();
  }

  Future<Null> delayTime() async {
    Duration duration = Duration(seconds: 1);
    await Timer(duration, () => readAllProduct());
  }

  Future<Null> readAllProduct() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('products')
          .snapshots()
          .listen((event) {
        for (var item in event.docs) {
          ProductModel model = ProductModel.fromMap(item.data());
          setState(() {
            productModels.add(model);
          });
        }
      });
      setState(() {
        searchProductModels = productModels;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(color: Colors.black12),
          child: TextFormField(
            onChanged: (value) {
              debouncer.run(() {
                setState(() {
                  searchProductModels =
                      productModels.where((element) => (element.name!.toLowerCase().contains(value.toLowerCase()))).toList();
                });
              });
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      body: productModels.length == 0
          ? ConfigProgress()
          : GridView.builder(
              itemCount: searchProductModels.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
              ),
              itemBuilder: (context, index) => Card(
                  child: Text(
                searchProductModels[index].name!,
              )),
            ),
    );
  }
}

class Debouncer {
  final int? millisecond;
  Timer? timer;
  VoidCallback? callBack;

  Debouncer({this.millisecond});

  run(VoidCallback callback) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: millisecond!), callback);
  }
}
