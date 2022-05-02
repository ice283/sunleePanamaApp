import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/providers/client_provider.dart';
import 'package:sunlee_panama/src/providers/navigation_provider.dart';
import 'package:sunlee_panama/src/providers/searching_provider.dart';
import 'package:sunlee_panama/src/screens/orders/order_page.dart';
import 'package:sunlee_panama/src/screens/products/products_page.dart';
import 'package:sunlee_panama/src/screens/profile/profile_page.dart';
import 'package:sunlee_panama/src/services/request/products_service.dart';
import 'package:sunlee_panama/src/widgets/botton_navigation_bar.dart';
import 'package:sunlee_panama/src/widgets/cart_icon_widget.dart';
import 'package:sunlee_panama/src/widgets/grid_product_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  TextEditingController _searchController = TextEditingController();
  String _searchData = '';

  @override
  Widget build(BuildContext context) {
    var ClientData = Provider.of<ClientNotifier>(context, listen: true);
    var navigation = Provider.of<NavigationProvider>(context, listen: true);
    var searching = Provider.of<SearchingProvider>(context, listen: true);

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
                    navigation.currentIndexUpdate = 0;
                    searching.searchingDataFn(_searchController.text);
                  },
                  decoration: InputDecoration(
                    hintText: 'Buscar Productos',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        (_searchController.text != '')
                            ? IconButton(
                                onPressed: () {
                                  searching.searchingDataFn('');
                                  _searchController.clear();
                                },
                                icon: Icon(
                                  Icons.cancel,
                                ),
                                color: Colors.grey,
                              )
                            : SizedBox(width: 0),
                        IconButton(
                            onPressed: () {
                              navigation.currentIndexUpdate = 0;
                              searching.searchingDataFn(_searchController.text);
                            },
                            icon: Icon(Icons.arrow_forward_ios)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            CartIconCounter(),
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(),
        body: PageView(
          controller: navigation.pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            productList(),
            OrderPage(),
            ProfilePage(),
            Container(
              color: Colors.red,
            ),
          ],
        ));
  }
}
