import 'dart:convert';
import 'dart:ui';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert' as Json;

import 'package:sunlee_panama/src/services/store/secure_store.dart';

class Request {
  late String data = '';
  late String url;
  late String token;
  dynamic body = '';
  //String _baseurl = 'http://192.168.10.147/well/sunlee/api/';
  String _baseurl = 'http://186.188.172.22/sunlee/api/';

  Request({
    required this.url,
    required this.token,
  });

  set setBody(dynamic value) {
    body = json.encode(value).toString();
  }

  Future<String> getData({required String url, String? token}) async {
    http.Response response = await http.get(Uri.parse(this._baseurl + url),
        headers: {
          'Authorization': '$token',
          'content-type': 'application/json;carset=utf-8'
        }).timeout(Duration(seconds: 5));
    return responseHandle(response);
  }

  Future<String> deleteData({required String url, String? token}) async {
    http.Response response = await http.delete(Uri.parse(this._baseurl + url),
        headers: {
          'Authorization': '$token',
          'content-type': 'application/json;carset=utf-8'
        }).timeout(Duration(seconds: 5));
    return responseHandle(response);
  }

  Future<String> postData(
      {required String url,
      required String token,
      required dynamic body}) async {
    http.Response response = await http
        .post(Uri.parse(this._baseurl + url),
            headers: {
              'Authorization': '$token',
              'content-type': 'application/json;carset=utf-8'
            },
            body: body)
        .timeout(Duration(seconds: 5));
    return responseHandle(response);
  }

  Future<String> putData(
      {required String url,
      required String token,
      required dynamic body}) async {
    http.Response response = await http
        .put(Uri.parse(this._baseurl + url),
            headers: {
              'Authorization': '$token',
              'content-type': 'application/json;carset=utf-8'
            },
            body: body)
        .timeout(Duration(seconds: 5));
    return responseHandle(response);
  }

  String responseHandle(http.Response response) {
    Map<String, dynamic> errorResponse = {"message": "error"};
    if (response.statusCode == 200 || response.statusCode == 201) {
      final _data = response.body.toString();
      return _data;
    } else if (response.statusCode == 401) {
      final StoreData storeJwt = StoreData();
      storeJwt.deleteAllData();
      final _data = response.body.toString();
      return _data;
    } else {
      final _data = response.body.toString();
      return _data;
    }
  }

  Future<String> execute(String method, Function(void) errorCallback) async {
    var response = '{"message":"error"}';
    try {
      switch (method) {
        case 'GET':
          response = await getData(url: url, token: token);
          return response;
          break;
        case 'POST':
          response = await postData(url: url, token: token, body: body);
          return response;
          break;
        case 'PUT':
          response = await putData(url: url, token: token, body: body);
          return response;
          break;
        case 'DELETE':
          response = await deleteData(url: url, token: token);
          return response;
          break;
      }
      return response;
    } catch (e) {
      errorCallback(e);
      return response;
    }
  }
}
