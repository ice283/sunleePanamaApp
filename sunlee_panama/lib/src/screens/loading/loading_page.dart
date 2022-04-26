import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/providers/client_provider.dart';
import 'package:sunlee_panama/src/screens/home/home_page.dart';
import 'package:sunlee_panama/src/screens/loading/check_logged.dart';
import 'package:sunlee_panama/src/screens/login/login_page.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isLogged(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != '') {
            var clientData = Provider.of<ClientNotifier>(context, listen: true);
            Fluttertoast.showToast(msg: 'Bienvenido! ${clientData.clientName}');
            return HomePage();
          } else {
            return LoginPage();
          }
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Scaffold(
          body: const Center(
            child: Text('Cargando...'),
            widthFactor: 50.0,
          ),
        );
      },
    );
  }
}
