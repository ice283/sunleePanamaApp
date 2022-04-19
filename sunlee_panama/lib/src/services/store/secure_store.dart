import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StoreData {
  final _storage = FlutterSecureStorage();
  String _response = '';

  Map<String, dynamic> convertJson(String response) {
    var jsonResponse = json.decode('{}');
    //print(response);
    try {
      jsonResponse = json.decode(response) as Map<String, dynamic>;
      //print('valid');
    } on FormatException catch (e) {
      //print('invalid');
    }
    return jsonResponse;
  }

  Future<void> storeJwt(String jwt) async {
    await _storage.write(key: 'jwt', value: jwt);
  }

  Future<void> save(String k, String val) async {
    await _storage.write(key: k, value: val);
  }

  Future<String> readKey(String k) async {
    String value = await _storage.read(key: k) ?? '';
    //print(value);
    _response = value;
    return value;
  }

  String reader(String k) {
    () async => await load(k);
    return _response;
  }

  Future<void> load(String k) async {
    await readKey(k);
  }

  Future<void> deleteAllData() async {
    await _storage.deleteAll();
  }
}
