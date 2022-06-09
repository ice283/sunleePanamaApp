import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:sunlee_panama/src/models/products_model.dart';
import 'package:sunlee_panama/src/services/http/http_handler.dart';
import 'package:sunlee_panama/src/services/store/secure_store.dart';
import 'package:sunlee_panama/src/utils/error_handler.dart';

class ProductsService {
  int _limit = 0;
  int _page = 1;
  int _rowsPerPage = 30;

  Future<List<Product>> getProducts(String? filter, String cat) async {
    StoreData storage = StoreData();
    String token = await storage.readKey('jwt');
    if (token == '') return [];
    final response = Request(
        url:
            'products/products_update_v220418.php?id_cat=$cat&order=$filter&limit=0,$_rowsPerPage',
        token: token);
    final decoded = json.decode(await response.execute('GET', (e) {
      ToastErrorHandler('Error de conexión');
    }));
    if (decoded['message'] == 'ok') {
      final peliculas = Products.fromJsonList(decoded['response']);
      _limit += _rowsPerPage;
      return peliculas.items;
    } else {
      return [];
    }
  }

  Future<List<Product>> loadMore(
      String? filter, String cat, String search, int page) async {
    StoreData storage = StoreData();
    int limit = (page > 1) ? page * _rowsPerPage : 0;
    String token = await storage.readKey('jwt');
    if (token == '') return [];
    final response = Request(
        url:
            'products/products_update_v220418.php?id_cat=$cat&order=$filter&search=$search&limit=$limit,$_rowsPerPage',
        token: token);
    final decoded = json.decode(await response.execute('GET', (e) {
      ToastErrorHandler('Error de conexión');
    }));
    if (decoded['message'] == 'ok') {
      final peliculas = Products.fromJsonList(decoded['response']);
      _limit += _rowsPerPage;
      return peliculas.items;
    } else {
      return [];
    }
  }

  Future<List<Product>> searchProducts(String search, String cat) async {
    StoreData storage = StoreData();
    final response = Request(
        url:
            'products/products_update_v220418.php?id_cat=$cat&search=$search&limit=0,100',
        token: await storage.readKey('jwt'));
    final decoded = json.decode(await response.execute('GET', (e) {
      ToastErrorHandler('Error de conexión');
    }));
    if (decoded['message'] == 'ok') {
      final peliculas = Products.fromJsonList(decoded['response']);
      return peliculas.items;
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getCategories() async {
    StoreData storage = StoreData();
    final response = Request(
        url: 'products/categories.php?show=all',
        token: await storage.readKey('jwt'));
    final decoded = json.decode(await response.execute('GET', (e) {
      ToastErrorHandler('Error de conexión');
    }));
    if (decoded['message'] == 'ok') {
      return decoded['response'];
    } else {
      return [];
    }
  }

  Future<List<Product>> scanProducts(String search) async {
    StoreData storage = StoreData();
    final response = Request(
        url: 'hproducts/products_update_v220418.php?product_code=$search',
        token: await storage.readKey('jwt'));
    final decoded = json.decode(await response.execute('GET', (e) {
      ToastErrorHandler('Error de conexión');
    }));
    if (decoded['message'] == 'ok') {
      final products = Products.fromJsonList(decoded['response']);
      return products.items;
    } else {
      return [];
    }
  }
}
