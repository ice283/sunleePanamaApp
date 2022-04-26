import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/providers/client_provider.dart';
import 'package:sunlee_panama/src/services/store/secure_store.dart';

Future<String> isLogged(BuildContext context) async {
  String logged = '';
  StoreData storage = StoreData();
  String token = await storage.readKey('jwt');
  if (token != '') {
    logged = token;
    var ClientData = Provider.of<ClientNotifier>(context, listen: false);

    if (await ClientData.getClientDataFromServer(token)) {
      logged = 'ok';
    }
  }
  return logged;
}
