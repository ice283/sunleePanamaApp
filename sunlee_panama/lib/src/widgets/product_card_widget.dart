import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/models/cart_model.dart';
import 'package:sunlee_panama/src/models/products_model.dart';
import 'package:sunlee_panama/src/providers/cart_provider.dart';
import 'package:sunlee_panama/src/providers/client_provider.dart';
import 'package:sunlee_panama/src/utils/common.functions.dart';

Widget ProductGridCard(BuildContext context, Product product) {
  var cartData = Provider.of<CartNotifier>(context, listen: false);
  var ClientData = Provider.of<ClientNotifier>(context, listen: true);
  bool isAvalible = (product.exist > 0) ? true : false;
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
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
              top: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    color: (product.exist > 0) ? Colors.green : Colors.red,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Icon(
                          (product.exist > 0)
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: Colors.white,
                          size: 12,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          (product.exist > 0) ? 'Disponible' : 'Agotado',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
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
                  (ClientData.price_permision == '0')
                      ? Text(
                          'Ref: ${product.refProdCode}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                          ),
                        )
                      : Text(
                          '\$ ${numberFormat(product.productSalePrice)}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
                  IconButton(
                      onPressed: () {
                        cartData.addItem(CartItem(
                          idCart: '0',
                          idProduct: product.idProduct,
                          productName: product.productName,
                          price: product.productSalePrice,
                          image: product.getImgUrl(),
                          quantity: 1,
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Agregado A la Cesta ${product.productName}'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: Icon(Icons.add_shopping_cart)),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
