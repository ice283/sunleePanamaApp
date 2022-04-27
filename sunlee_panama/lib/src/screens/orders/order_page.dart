import 'package:flutter/material.dart';
import 'package:sunlee_panama/src/widgets/botton_navigation_bar.dart';
import 'package:sunlee_panama/src/widgets/cart_icon_widget.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OrderPage'),
        actions: [
          CartIconCounter(),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(1),
      body: Center(
        child: Text('OrderPage'),
      ),
    );
  }
}
