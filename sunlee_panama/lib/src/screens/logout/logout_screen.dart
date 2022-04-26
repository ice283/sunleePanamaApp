import 'package:flutter/material.dart';
import 'package:sunlee_panama/src/services/store/secure_store.dart';

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StoreData storeJwt = StoreData();
    storeJwt.deleteAllData();
    Navigator.pushReplacementNamed(
      context,
      '/login',
    );
    return Container();
  }

  void execute() {}
}
