import 'dart:convert';
import 'package:sunlee_panama/src/services/http/http_handler.dart';
import 'package:sunlee_panama/src/services/store/secure_store.dart';
import 'package:sunlee_panama/src/utils/error_handler.dart';

class UploadOrderProvider {
  Future<Map<dynamic, dynamic>> send(Map<dynamic, dynamic> data) async {
    StoreData storage = StoreData();
    final response = Request(
        url: 'orders/orders.controller.php',
        token: await storage.readKey('jwt'));
    response.setBody = data;
    final decoded = json.decode(await response.execute('POST', (e) {
      ToastErrorHandler('Error de conexión');
    }));
    if (decoded['message'] == 'ok') {
      return decoded;
    } else {
      ToastErrorHandler('Error de conexión');
      return {};
    }
  }
}
