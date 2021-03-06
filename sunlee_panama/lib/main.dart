import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/app.dart';
import 'package:sunlee_panama/src/providers/cart_provider.dart';
import 'package:sunlee_panama/src/providers/client_provider.dart';
import 'package:sunlee_panama/src/providers/navigation_provider.dart';
import 'package:sunlee_panama/src/providers/searching_provider.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClientNotifier()),
        ChangeNotifierProvider(create: (_) => CartNotifier()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => SearchingProvider()),
      ],
      child: MyApp(),
    ),
  );
  // runApp(MyApp());
}
