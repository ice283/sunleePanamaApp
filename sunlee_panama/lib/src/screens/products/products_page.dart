import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/providers/searching_provider.dart';
import 'package:sunlee_panama/src/services/request/products_service.dart';
import 'package:sunlee_panama/src/widgets/loading_widget.dart';
import 'package:sunlee_panama/src/widgets/product_card_widget.dart';

class productList extends StatefulWidget {
  @override
  State<productList> createState() => _productListState();
}

class _productListState extends State<productList>
    with AutomaticKeepAliveClientMixin<productList> {
  @override
  Widget build(BuildContext context) {
    var searching = Provider.of<SearchingProvider>(context, listen: true);
    ProductsService productsService = ProductsService();
    return (searching.isSearching)
        ? LoadingWidget(
            text: 'Loading...',
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 0.70,
              crossAxisCount: 2,
            ),
            itemCount: searching.products.length,
            padding: EdgeInsets.all(8.0),
            itemBuilder: (BuildContext context, int index) {
              return ProductGridCard(context, searching.products[index]);
            },
          );
  }

  @override
  bool get wantKeepAlive => true;
}