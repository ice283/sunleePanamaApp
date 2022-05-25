import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/providers/client_provider.dart';
import 'package:sunlee_panama/src/providers/searching_provider.dart';
import 'package:sunlee_panama/src/services/store/secure_store.dart';
import 'package:sunlee_panama/src/utils/error_handler.dart';

Future<String> isLogged(BuildContext context) async {
  String logged = '';
  StoreData storage = StoreData();
  String token = await storage.readKey('jwt');
  if (token != '') {
    logged = token;
    var ClientData = Provider.of<ClientNotifier>(context, listen: false);

    if (await ClientData.getClientDataFromServer(token)) {
      var searching = Provider.of<SearchingProvider>(context, listen: false);
      await searching.initializeProducts();
      logged = 'ok';
    }
  } else {
    ToastErrorHandler('Debe Loguearse');
  }
  return logged;
}
