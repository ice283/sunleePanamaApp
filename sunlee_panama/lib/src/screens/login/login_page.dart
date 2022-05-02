import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/models/clients_model.dart';
import 'package:sunlee_panama/src/providers/client_provider.dart';
import 'package:sunlee_panama/src/services/http/http_handler.dart';
import 'package:sunlee_panama/src/services/request/client_service.dart';
import 'package:sunlee_panama/src/services/store/secure_store.dart';
import 'package:sunlee_panama/src/utils/error_handler.dart';
import 'package:sunlee_panama/src/widgets/loading_widget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';
  bool _showPassword = true;
  final String _responseBody = 'vacio';
  final String _error = 'nada';
  bool _pending = false;
  @override
  Widget build(BuildContext context) {
    final bodyProgress = LoadingWidget();
    final _body = Stack(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image(
          fit: BoxFit.cover,
          color: Colors.white.withOpacity(0.2),
          colorBlendMode: BlendMode.modulate,
          image: AssetImage('assets/images/bg_food.jpeg'),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Image(
                height: 200.0,
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Usuario:',
                prefixIcon: Icon(Icons.mail),
              ),
              onFieldSubmitted: (text) {
                _email = text;
                //print(_email);
              },
              onChanged: (text) {
                _email = text;
                //print(_email);
              },
              onSaved: (text) {
                _email = text!;
                //print('sumited');
              },
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: _showPassword,
              decoration: InputDecoration(
                labelText: 'Password:',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: _showPassword ? Colors.grey : Colors.red[700],
                    ),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    }),
              ),
              onChanged: (text) {
                if (text != null) {
                  _password = text;
                  //print(_password);
                }
              },
              onSubmitted: (text) {
                _password = text;
                //print(_password);
              },
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 25.0,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _pending = true;
                    });
                    bool _validate = await show(context, _email, _password);
                    if (_validate) {
                      Navigator.pushReplacementNamed(
                        context,
                        '/home',
                      );
                    }
                    setState(() {
                      _pending = false;
                    });
                  },
                  child: Text('Ingresar'),
                ),
              ),
              SizedBox(
                width: 25.0,
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 25.0,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/register',
                    );
                  },
                  child: Text('Registrarse'),
                ),
              ),
              SizedBox(
                width: 25.0,
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 25.0,
              ),
              TextButton(
                child: Text(
                  'Olvidaste tu Clave?',
                ),
                onPressed: () {},
              ),
              SizedBox(
                width: 25.0,
              ),
            ],
          ),
          SizedBox(
            height: 25.0,
          ),
        ],
      ),
    ]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pending ? bodyProgress : _body,
    );
  }
}

Future<bool> show(BuildContext context, _email, _password) async {
  ClientService _clientService = ClientService();
  return _clientService.loginClient(context, _email, _password);
}
