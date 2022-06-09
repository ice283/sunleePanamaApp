import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/models/products_model.dart';
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
  ScrollController scrollController = ScrollController(keepScrollOffset: true);
  bool showbtn = false;
  bool _isSearching = false;
  @override
  void initState() {
    scrollController.addListener(() => _scrollListener(context));
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(() => _scrollListener(context));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var searching = Provider.of<SearchingProvider>(context, listen: true);
    return (searching.isSearching)
        ? LoadingWidget(
            text: 'Loading...',
          )
        : (searching.products.length == 0)
            ? Center(child: Text('No hay resultados'))
            : GridView.builder(
                controller: scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                  childAspectRatio: 0.60,
                  crossAxisCount: 2,
                ),
                itemCount: searching.products.length + 1,
                padding: EdgeInsets.all(8.0),
                itemBuilder: (BuildContext context, int index) {
                  return (index < searching.products.length)
                      ? ProductGridCard(context, searching.products[index])
                      : (searching.loadingMore)
                          ? LoadingWidget()
                          : Container(
                              height: 10,
                            );
                },
              );
  }

  @override
  bool get wantKeepAlive => true;

  _scrollListener(BuildContext context) {
    var searching = Provider.of<SearchingProvider>(context, listen: false);
    if (scrollController.positions.isNotEmpty) {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent - 100 &&
          !scrollController.position.outOfRange) {
        searching.loadMore(searching.searchData);
      }
    }
  }
}
