import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/providers/client_provider.dart';
import 'package:sunlee_panama/src/services/request/products_provider.dart';
import 'package:sunlee_panama/src/widgets/botton_navigation_bar.dart';
import 'package:sunlee_panama/src/widgets/cart_icon_widget.dart';
import 'package:sunlee_panama/src/widgets/grid_product_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  String _searchData = '';

  @override
  Widget build(BuildContext context) {
    var ClientData = Provider.of<ClientNotifier>(context, listen: true);
    int _currentIndex = 0;

    var _searchingData = ValueNotifier(_searchData);
    ProductsService productsService = ProductsService();

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 75.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.fitWidth,
            height: 40.0,
          ),
        ),
        title: Text('Sunlee Panama'),
        centerTitle: true,
        bottom: AppBar(
          leading: Container(),
          leadingWidth: 0,
          title: Container(
            width: double.infinity,
            height: 40,
            color: Colors.white,
            child: Center(
              child: TextField(
                controller: _searchController,
                onSubmitted: (value) {
                  _searchData = value;
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'Buscar Productos',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                      onPressed: () {
                        _searchData = _searchController.text;
                        setState(() {});
                      },
                      icon: Icon(Icons.arrow_forward_ios)),
                ),
              ),
            ),
          ),
        ),
        actions: [
          CartIconCounter(),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(0),
      body: ValueListenableBuilder<String>(
        valueListenable: _searchingData,
        builder: (context, value, child) {
          return GridProductBuilder(
              productsService: productsService, searchData: _searchData);
        },
      ),
    );
  }
}
