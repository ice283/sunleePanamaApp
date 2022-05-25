import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/models/clients_model.dart';
import 'package:sunlee_panama/src/models/detail_client_model.dart';
import 'package:sunlee_panama/src/providers/client_provider.dart';
import 'package:sunlee_panama/src/services/http/http_handler.dart';
import 'package:sunlee_panama/src/services/store/secure_store.dart';
import 'package:sunlee_panama/src/utils/error_handler.dart';

class ClientService {
  Future<List<dynamic>> getDocument(String id) async {
    StoreData storage = StoreData();
    final request = Request(
        url: 'report/report.php?id=$id', token: await storage.readKey('jwt'));
    final response = jsonDecode(await request.execute('GET', (e) {
      ToastErrorHandler('Error de conexión');
    }));
    if (response['message'] == 'ok') {
      return [
        response['header'],
        response['content'],
      ];
    } else {
      ToastErrorHandler('Error desconocido');
      return [];
    }
  }

  Future<DetailClientData> detailClient(String id) async {
    StoreData storage = StoreData();
    final request = Request(
        url: 'client/client.controller.php?id=$id',
        token: await storage.readKey('jwt'));
    final decoded = json.decode(await request.execute('GET', (e) {
      ToastErrorHandler('Error de conexión');
    }));
    if (decoded['message'] == 'ok') {
      final DetailClientData clients =
          DetailClientData.fromJsonList(decoded['data']['balance']);

      clients.facs = (decoded['data']['totals']['FACS'] != null)
          ? decoded['data']['totals']['FACS']
          : 0;
      clients.total = (decoded['data']['totals']['TOTAL'] != '')
          ? decoded['data']['totals']['TOTAL'].toDouble()
          : 0.00;
      clients.pagos = (decoded['data']['totals']['PAGOS'] != '')
          ? decoded['data']['totals']['PAGOS'].toDouble()
          : 0.00;
      clients.pendientes = (decoded['data']['totals']['PENDIENTES'] != '')
          ? decoded['data']['totals']['PENDIENTES'].toDouble()
          : 0.00;
      //print(decoded);
      return clients;
    } else {
      final DetailClientData clients = DetailClientData.fromJsonList([]);
      ToastErrorHandler('Error de conexión');
      return clients;
    }
  }

  Future<bool> registerClient(String _email, String _password,
      String _clientName, String _contactName) async {
    StoreData storage = StoreData();
    Map _body = {
      'action': 'register',
      'client_mail': _email,
      'password': _password,
      'client_name': _clientName,
      'contact_name': _contactName,
    };
    final request = Request(url: 'auth/client.php', token: '');
    request.setBody = _body;
    final decoded = json.decode(await request.execute('POST', (e) {
      ToastErrorHandler('Error de conexión');
    }));
    if (decoded['error'] == '') {
      ToastErrorHandler(
          'Se enviaron los datos al Servidor debe esperar el correo de confirmacion de cuenta');
      return true;
    } else {
      switch (decoded['error_code']) {
        case 1002:
          ToastErrorHandler('Campos Vacios');
          break;
        case 1001:
          ToastErrorHandler('Correo ya existe');
          break;
        default:
          ToastErrorHandler('Error desconocido');
      }
      return false;
    }
  }

  Future<bool> loginClient(
      BuildContext context, String _email, String _password) async {
    StoreData storage = StoreData();
    if (_email == '' || _password == '') {
      ToastErrorHandler('Debe colocar su correo y su clave');
      return false;
    }
    Map _body = {
      'action': 'login',
      'client_mail': _email,
      'password': _password,
    };
    final request = Request(url: 'auth/client.php', token: '');
    request.setBody = _body;
    final response = jsonDecode(await request.execute('POST', (e) {
      ToastErrorHandler('Error de conexión');
    }));
    if (response['error'] == '') {
      StoreData storage = StoreData();
      storage.storeJwt('Bearer ' + response['token']);
      storage.save('client_name', response['data']['client_name']);
      storage.save('id_client', response['data']['id_client']);
      var ClientData = Provider.of<ClientNotifier>(context, listen: false);
      ClientData.updateUser(Client.fromJson(response['data']));
      return true;
    } else {
      switch (response['error_code']) {
        case 1002:
          ToastErrorHandler('Campos Vacios');
          break;
        case 1001:
          ToastErrorHandler('Correo ya existe');
          break;
        case 1003:
          ToastErrorHandler('Cuenta Inactiva');
          break;
        case 5001:
          ToastErrorHandler('Sin acceso a Internet');
          break;
        default:
          ToastErrorHandler('Error desconocido');
      }
      return false;
    }
  }

  Future<Map<String, dynamic>> getClientDataFromServer(String token) async {
    final request = Request(url: 'auth/client.php', token: token);
    final response = jsonDecode(await request.execute('GET', (e) {
      ToastErrorHandler('Error de conexión');
    }));
    if (response['message'] == 'ok') {
      return response;
    } else {
      switch (response['error_code']) {
        case 1002:
          ToastErrorHandler('Campos Vacios');
          break;
        case 1001:
          ToastErrorHandler('Correo ya existe');
          break;
        case 1003:
          ToastErrorHandler('Cuenta Inactiva');
          break;
        default:
          ToastErrorHandler('Error desconocido');
      }
      return {
        'message': 'error',
      };
    }
  }

  Future<Map<String, dynamic>> updateClient(Client client) async {
    StoreData storage = StoreData();
    final request =
        Request(url: 'auth/client.php', token: await storage.readKey('jwt'));
    request.setBody = client.toJson();
    final response = jsonDecode(await request.execute('PUT', (e) {
      ToastErrorHandler('Error de conexión');
    }));
    if (response['message'] == 'ok') {
      return response['data'];
    } else {
      switch (response['error_code']) {
        case 1002:
          ToastErrorHandler('Campos Vacios');
          break;
        case 1001:
          ToastErrorHandler('Correo ya existe');
          break;
        case 1003:
          ToastErrorHandler('Cuenta Inactiva');
          break;
        default:
          ToastErrorHandler('Error desconocido');
      }
      return {
        'message': 'error',
      };
    }
  }
}
