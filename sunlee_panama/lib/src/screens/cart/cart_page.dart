import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:sunlee_panama/src/widgets/botton_navigation_bar.dart';

class CartSumaryPage extends StatelessWidget {
  const CartSumaryPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CartSumaryPage'),
      ),
      bottomNavigationBar: CustomNavigationBar(1),
      body: Center(
        child: Text('CartSumaryPage'),
      ),
    );
  }
}
