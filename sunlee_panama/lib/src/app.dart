import 'package:flutter/material.dart';
import 'package:sunlee_panama/src/screens/blank_page/blank_page.dart';
import 'package:sunlee_panama/src/screens/cart/cart_page.dart';
import 'package:sunlee_panama/src/screens/home/home_page.dart';
import 'package:sunlee_panama/src/screens/loading/loading_page.dart';
import 'package:sunlee_panama/src/screens/login/login_page.dart';
import 'package:sunlee_panama/src/screens/logout/logout_screen.dart';
import 'package:sunlee_panama/src/screens/products/detail_produst_page.dart';
import 'package:sunlee_panama/src/screens/profile/profile_page.dart';
import 'package:sunlee_panama/src/screens/register/register_page.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sunlee Panama',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => LoadingPage(),
        '/login': (BuildContext context) => LoginPage(),
        '/blank': (BuildContext context) => BlankPage(
              title: 'Vacio',
            ),
        '/register': (BuildContext context) => RegisterPage(),
        '/home': (BuildContext context) => HomePage(),
        '/profile': (BuildContext context) => ProfilePage(),
        '/detailProduct': (BuildContext context) => DetailProductPage(),
        '/cart': (BuildContext context) => CartSumaryPage(),
        '/orders': (BuildContext context) => BlankPage(
              title: 'orders',
            ),
      },
    );
  }
}
