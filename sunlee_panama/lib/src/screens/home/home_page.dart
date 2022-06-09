import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/providers/client_provider.dart';
import 'package:sunlee_panama/src/providers/navigation_provider.dart';
import 'package:sunlee_panama/src/providers/searching_provider.dart';
import 'package:sunlee_panama/src/screens/orders/order_page.dart';
import 'package:sunlee_panama/src/screens/products/products_page.dart';
import 'package:sunlee_panama/src/screens/profile/profile_page.dart';
import 'package:sunlee_panama/src/widgets/botton_navigation_bar.dart';
import 'package:sunlee_panama/src/widgets/cart_icon_widget.dart';
import 'package:sunlee_panama/src/widgets/categories_carrousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FocusNode myFocusNode;

  @override
  void initState() {
    myFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  TextEditingController _searchController = TextEditingController();
  String _searchData = '';
  final debouncer =
      Debouncer<String>(const Duration(milliseconds: 500), initialValue: '');

  @override
  Widget build(BuildContext context) {
    var ClientData = Provider.of<ClientNotifier>(context, listen: true);
    var navigation = Provider.of<NavigationProvider>(context, listen: true);
    var searching = Provider.of<SearchingProvider>(context, listen: true);
    Future<void> _getProducts(String query) async {
      debouncer.value = query;
      searching.searchingDataFn(await debouncer.nextValue);
    }

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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(90.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  color: Colors.white,
                  child: Center(
                    child: TextField(
                      controller: _searchController,
                      focusNode: myFocusNode,
                      autofocus: false,
                      onTap: () {
                        setState(() {});
                      },
                      onChanged: (value) async {
                        navigation.currentIndexUpdate = 0;
                        _getProducts(_searchController.text);
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'Buscar Productos',
                        prefixIcon: (myFocusNode.hasFocus)
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    searching.searchingDataFn('');
                                    _searchController.clear();
                                    myFocusNode.unfocus();
                                  });
                                },
                                icon: Icon(Icons.arrow_back))
                            : Icon(Icons.search),
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
                                  searching
                                      .searchingDataFn(_searchController.text);
                                },
                                icon: Icon(Icons.arrow_forward_ios)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              CategoriesCarrousel(),
              SizedBox(height: 10),
            ],
          ),
        ),
        actions: [
          CartIconCounter(),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(),
      body: pages[navigation.currentIndex],
    );
  }

  List<Widget> pages = [
    productList(),
    OrderPage(),
    ProfilePage(),
  ];
}
