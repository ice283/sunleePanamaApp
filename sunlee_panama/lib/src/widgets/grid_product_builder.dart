import 'package:flutter/material.dart';
import 'package:sunlee_panama/src/services/request/products_provider.dart';
import 'package:sunlee_panama/src/widgets/loading_widget.dart';
import 'package:sunlee_panama/src/widgets/product_card_widget.dart';

class GridProductBuilder extends StatelessWidget {
  const GridProductBuilder({
    Key? key,
    required this.productsService,
    required String searchData,
  })  : _searchData = searchData,
        super(key: key);

  final ProductsService productsService;
  final String _searchData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: productsService.searchProducts(context, _searchData),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWidget();
        }
        if (snapshot.hasData) {
          final products = snapshot.data;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 0.70,
              crossAxisCount: 2,
            ),
            itemCount: products.length,
            padding: EdgeInsets.all(8.0),
            itemBuilder: (BuildContext context, int index) {
              return ProductGridCard(context, products[index]);
            },
          );
        } else {
          return Center(
            child: LoadingWidget(
              text: 'Cargando Productos...',
            ),
          );
        }
      },
    );
  }
}
