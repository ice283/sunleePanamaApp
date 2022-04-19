import 'package:flutter/material.dart';
import 'package:sunlee_panama/src/screens/login/login_page.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool logged = true;
    if (logged) {
      return LoginPage();
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
