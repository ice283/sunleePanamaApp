import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sunlee_panama/src/models/clients_model.dart';
import 'package:sunlee_panama/src/services/http/http_handler.dart';
import 'package:sunlee_panama/src/services/store/secure_store.dart';
import 'package:sunlee_panama/src/utils/error_handler.dart';

class ClientNotifier extends ChangeNotifier {
  String idClient = '';
  String codeClient = '';
  String clientName = '';
  String clientRuc = '';
  String clientDv = '';
  String clientMail = '';
  String clientPhotoUrl = '';
  dynamic clientAddress = '';
  DateTime createdAt = DateTime.parse('0000-00-00 00:00:00');
  DateTime updatedAt = DateTime.parse('0000-00-00 00:00:00');
  dynamic token = '';
  String contactName = '';
  String clientStatus = '';
  String lastlogin = '';
  String clientCreditDays = '';
  DateTime topSale = DateTime.parse('0000-00-00 00:00:00');
  String active = '';
  String appClient = '';
  String password = '';

  void updateUser(Client clientData) {
    idClient = clientData.idClient;
    codeClient = clientData.codeClient;
    clientName = clientData.clientName;
    clientRuc = clientData.clientRuc;
    clientDv = clientData.clientDv;
    clientMail = clientData.clientMail;
    clientPhotoUrl = clientData.clientPhotoUrl;
    clientAddress = clientData.clientAddress;
    createdAt = clientData.createdAt;
    updatedAt = clientData.updatedAt;
    token = clientData.token;
    contactName = clientData.contactName;
    clientStatus = clientData.clientStatus;
    lastlogin = clientData.lastlogin;
    clientCreditDays = clientData.clientCreditDays;
    topSale = clientData.topSale;
    active = clientData.active;
    appClient = clientData.appClient;
    password = clientData.password;
    notifyListeners();
  }

  Future<bool> getClientDataFromServer(String token) async {
    final request = Request(url: 'auth/client.php', token: token, body: '{}');
    final response = jsonDecode(await request.execute('GET', (e) {
      ToastErrorHandler('Error de conexión');
    }));
    if (response['message'] == 'ok') {
      Client clientData = Client.fromJson(response['data']);
      updateUser(clientData);
      final StoreData storeJwt = StoreData();
      storeJwt.save('clientData', clientData.toJson().toString());
      return true;
    } else {
      return false;
    }
  }
}
