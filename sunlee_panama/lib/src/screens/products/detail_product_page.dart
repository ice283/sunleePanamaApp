import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sunlee_panama/src/models/products_model.dart';
import 'package:sunlee_panama/src/widgets/cart_icon_widget.dart';

class DetailProductPage extends StatelessWidget {
  const DetailProductPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text('DetailProductPage'),
      ),
      body: Center(
        child: Hero(
          tag: product.idProduct,
          child: CachedNetworkImage(
            fadeInDuration: const Duration(milliseconds: 100),
            fadeOutDuration: const Duration(milliseconds: 100),
            placeholder: (context, url) => Image.asset(
              'assets/images/placeholder-image.jpeg',
              fit: BoxFit.fitWidth,
            ),
            imageUrl: product.getImgUrl(),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
