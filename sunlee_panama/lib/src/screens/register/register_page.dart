import 'package:flutter/material.dart';

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
                  onPressed: () {},
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
          RegisterFormInput('Nombre:', Icons.person_sharp, (m) => print(m)),
          RegisterFormInput('Compañia:', Icons.business, (m) => print(m)),
          RegisterFormInput('Correo Electronico:', Icons.mail, (m) => print(m)),
          RegisterFormInput('Clave:', Icons.person_sharp, (m) => print(m),
              password: true, obscureText: _showPassword),
          RegisterFormInput(
              'Repetir Clave:', Icons.person_sharp, (m) => print(m),
              password: false, obscureText: _showPassword),
          SizedBox(
            height: 20.0,
          ),
          /* Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50.0,
                  ),
                ),
                ElevatedButton(
                  child: Text('Restablecer'),
                  onPressed: () {
                    _showPassword = false;
                    _companyName = '';
                    _contactName = '';
                    _email = '';
                    _password = '';
                    _repeatPassword = '';
                    setState(() {});
                  },
                ),
              ],
            ),
          ), */
        ],
      ),
    );
  }

  Widget RegisterFormInput(String title, IconData icon, Function callback,
      {bool password = false, bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        obscureText: obscureText,
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
}
