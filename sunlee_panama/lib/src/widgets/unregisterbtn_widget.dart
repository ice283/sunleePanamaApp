import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/providers/navigation_provider.dart';
import 'package:sunlee_panama/src/services/store/secure_store.dart';

class unregisterBtn extends StatelessWidget {
  const unregisterBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigation = Provider.of<NavigationProvider>(context, listen: false);
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? Colors.red
                  : Colors.red[800]),
        ),
        onPressed: () {
          final StoreData storeJwt = StoreData();
          storeJwt.deleteAllData();
          navigation.currentIndex = 0;
          Navigator.pushNamed(context, '/unregister');
        },
        child: Text('Eliminar Cuenta'));
  }
}
