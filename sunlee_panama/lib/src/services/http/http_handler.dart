import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert' as Json;

class Request {
  late String data = '';
  late String url;
  late String token;
  late String body = '';
  String _baseurl = 'http://186.188.172.22/api/';

  Request({
    required this.url,
    required this.token,
    this.body = '',
  });

  Future<String> getData({required String url, String? token}) async {
    http.Response response = await http.get(Uri.parse(this._baseurl + url),
        headers: {
          'auth-token': '$token',
          'content-type': 'application/json;carset=utf-8'
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      data = response.body.toString();
      return data;
    } else {
      data = response.body.toString();
      return data;
    }
  }

  Future<String> deleteData({required String url, String? token}) async {
    http.Response response = await http.delete(Uri.parse(this._baseurl + url),
        headers: {
          'auth-token': '$token',
          'content-type': 'application/json;carset=utf-8'
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      data = response.body.toString();
      return data;
    } else {
      data = response.body.toString();
      return data;
    }
  }

  Future<String> postData(
      {required String url,
      required String token,
      required String body}) async {
    http.Response response = await http.post(Uri.parse(this._baseurl + url),
        headers: {
          'auth-token': '$token',
          'content-type': 'application/json;carset=utf-8'
        },
        body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      data = response.body.toString();
      return data;
    } else {
      data = response.body.toString();
      return data;
    }
  }

  Future<String> putData(
      {required String url,
      required String token,
      required String body}) async {
    http.Response response = await http.put(Uri.parse(this._baseurl + url),
        headers: {
          'auth-token': '$token',
          'content-type': 'application/json;carset=utf-8'
        },
        body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      data = response.body.toString();
      return data;
    } else {
      data = response.body.toString();
      return data;
    }
  }

  Future<String> execute(String method) async {
    var response = '{"message":"error"}';
    switch (method) {
      case 'get':
        response = await getData(url: url, token: token);
        return response;
        break;
      case 'post':
        response = await postData(url: url, token: token, body: body);
        return response;
        break;
      case 'put':
        response = await postData(url: url, token: token, body: body);
        return response;
        break;
      case 'delete':
        response = await deleteData(url: url, token: token);
        return response;
        break;
    }
    return response;
  }
}
