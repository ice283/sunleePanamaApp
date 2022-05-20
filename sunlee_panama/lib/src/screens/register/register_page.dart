import 'package:flutter/material.dart';
import 'package:sunlee_panama/src/services/request/client_service.dart';
import 'package:sunlee_panama/src/utils/error_handler.dart';
import 'package:sunlee_panama/src/utils/validator_fn.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email = '';
  String _password = '';
  String _repeatPassword = '';
  String _contactName = '';
  String _companyName = '';
  bool _showPassword = true;
  String _responseBody = '';
  String _error = '';
  bool _pending = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrarse'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: ElevatedButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: ElevatedButton(
                  child: Text('Registrarse'),
                  onPressed: () {
                    _submit();
                  },
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Center(
            child: Image(
              height: 100.0,
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  RegisterFormInput(
                    'Nombre:',
                    Icons.person_sharp,
                    (m) => _contactName = m,
                    (m) => notEmpty(m) ? null : 'El nombre es Requerido',
                  ),
                  RegisterFormInput(
                    'Compañia:',
                    Icons.business,
                    (m) => _companyName = m,
                    (m) => notEmpty(m) ? null : 'La Compania es Requerido',
                  ),
                  RegisterFormInput(
                    'Correo Electronico:',
                    Icons.mail,
                    (m) => _email = m,
                    (m) => isEmail(m) ? null : 'Correo invalido',
                  ),
                  RegisterFormInput(
                    'Clave:',
                    Icons.person_sharp,
                    (m) => _password = m,
                    (m) => notEmpty(m) ? null : 'No puede estar vacio',
                    password: true,
                    obscureText: _showPassword,
                  ),
                  RegisterFormInput(
                    'Repetir Clave:',
                    Icons.person_sharp,
                    (m) => _repeatPassword = m,
                    (m) => compare(m, _password)
                        ? null
                        : 'las claves no coinciden',
                    password: false,
                    obscureText: _showPassword,
                  ),
                ],
              )),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  Widget RegisterFormInput(
    String title,
    IconData icon,
    Function callback,
    Function validate, {
    bool password = false,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        obscureText: obscureText,
        validator: (value) {
          return validate(value);
        },
        decoration: InputDecoration(
          suffixIcon: (!password)
              ? null
              : IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: obscureText ? Colors.grey : Colors.red[700],
                  ),
                  onPressed: () {
                    setState(() {
                      this._showPassword = !this._showPassword;
                    });
                  }),
          labelText: title,
          prefixIcon: Icon(icon),
        ),
        onFieldSubmitted: (text) {
          callback(text);
        },
        onChanged: (text) {
          callback(text);
        },
        onSaved: (text) {
          callback(text);
        },
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    ClientService clientService = ClientService();
    setState(() {
      _pending = true;
    });
    if (await clientService.registerClient(
        _email, _password, _companyName, _contactName)) {
      setState(() {
        _pending = false;
      });
      Navigator.pop(context);
    }
  }
}
