import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/models/products_model.dart';
import 'package:sunlee_panama/src/providers/cart_provider.dart';
import 'package:sunlee_panama/src/utils/common.functions.dart';

Widget ProductGridCard(BuildContext context, Product product) {
  var cartData = Provider.of<CartNotifier>(context, listen: false);
  bool isAvalible = (product.exist > 0) ? true : false;
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
    ),
    child: Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            '/detailProduct',
            arguments: product,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Hero(
              tag: product.idProduct,
              child: CachedNetworkImage(
                fadeInDuration: const Duration(milliseconds: 100),
                fadeOutDuration: const Duration(milliseconds: 100),
                placeholder: (context, url) => Image.asset(
                  'assets/images/placeholder-image.jpeg',
                  fit: BoxFit.fitWidth,
                ),
                height: 200.0,
                imageUrl: product.getImgUrl(),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 5.0,
          left: 10.0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  product.productName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      '\$ ${numberFormat(product.productSalePrice)}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          cartData.addItem(product);
                        },
                        icon: Icon(Icons.add_shopping_cart)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
