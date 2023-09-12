

import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  // static const String id="/orderScreen";
  static const routeName = '/orderScreen';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("order Screen"),),
    );
  }
}
