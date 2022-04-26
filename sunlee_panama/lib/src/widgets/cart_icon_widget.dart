import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/providers/cart_provider.dart';

class CartIconCounter extends StatelessWidget {
  const CartIconCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartData = Provider.of<CartNotifier>(context, listen: true);
    return Row(
      children: [
        IconButton(
            icon: Badge(
              badgeContent: Text(cartData.items.toString(),
                  style: TextStyle(fontSize: 9.0)),
              position: BadgePosition.topEnd(top: -10, end: -15),
              badgeColor: Colors.white,
              elevation: 4.00,
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 25.00,
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            }),
        SizedBox(width: 10),
      ],
    );
  }
}
