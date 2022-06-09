import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/providers/searching_provider.dart';
import 'package:sunlee_panama/src/services/request/products_service.dart';
import 'package:sunlee_panama/src/widgets/loading_widget.dart';
import 'package:sunlee_panama/src/widgets/product_card_widget.dart';

class GridProductBuilder extends StatefulWidget {
  @override
  State<GridProductBuilder> createState() => _GridProductBuilderState();
}

class _GridProductBuilderState extends State<GridProductBuilder> {
  ScrollController scrollController = ScrollController();
  bool showbtn = false;

  @override
  void initState() {
    scrollController.addListener(() {
      showbtn = true;
      print(scrollController.offset);
      setState(() {
        //update state
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var searching = Provider.of<SearchingProvider>(context, listen: true);
    ProductsService productsService = ProductsService();
    return FutureBuilder(
      future: productsService.searchProducts(
          searching.searchingData, searching.selectedCategorie),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWidget();
        }
        if (snapshot.hasData) {
          final products = snapshot.data;
          return GridView.builder(
            controller: scrollController,
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
