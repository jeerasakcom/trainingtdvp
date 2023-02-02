
import 'package:flutter/material.dart';
import 'package:tdvp/components/frontend/customer/carts/lists_carts.dart';


class AddCartsPages extends StatelessWidget {
  final Function()? callBackFunc;
  const AddCartsPages({
    Key? key,
    this.callBackFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ListsCartsPages(),
              ),
            ).then((value) => callBackFunc),
        icon: Icon(Icons.shopping_cart));
  }
}
