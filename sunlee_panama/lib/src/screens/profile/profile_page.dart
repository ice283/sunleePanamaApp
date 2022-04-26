import 'package:flutter/material.dart';
import 'package:sunlee_panama/src/services/store/secure_store.dart';
import 'package:sunlee_panama/src/widgets/botton_navigation_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfilePage'),
      ),
      bottomNavigationBar: CustomNavigationBar(3),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                final StoreData storeJwt = StoreData();
                storeJwt.deleteAllData();
                Navigator.pushNamed(context, '/login');
              },
              child: Text('salir'))),
    );
  }
}
