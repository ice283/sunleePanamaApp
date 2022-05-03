import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunlee_panama/src/models/clients_model.dart';
import 'package:sunlee_panama/src/providers/client_provider.dart';
import 'package:sunlee_panama/src/providers/navigation_provider.dart';
import 'package:sunlee_panama/src/services/request/client_service.dart';
import 'package:sunlee_panama/src/services/store/secure_store.dart';
import 'package:sunlee_panama/src/utils/error_handler.dart';
import 'package:sunlee_panama/src/utils/validator_fn.dart';
import 'package:sunlee_panama/src/widgets/formField_data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var ClientData = Provider.of<ClientNotifier>(context, listen: true);

    Client client = Client.fromJson(ClientData.toJson());
    return Column(
      children: <Widget>[
        Container(
            height: 50,
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      '${ClientData.contactName} (${ClientData.codeClient})',
                      style: TextStyle(fontSize: 16)),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _send(formKey: formKey, client: client),
                ),
              ],
            )),
        Divider(),
        Expanded(
          child: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                FormFieldData(
                  title: 'Nombre:',
                  initialValue: ClientData.contactName,
                  icon: Icons.person,
                  callback: (text) => client.contactName = text,
                  validate: (text) =>
                      (notEmpty(text)) ? null : 'No puede estar vacio',
                ),
                FormFieldData(
                  title: 'Compañia:',
                  initialValue: ClientData.clientName,
                  icon: Icons.business,
                  callback: (text) => client.clientName = text,
                  validate: (text) =>
                      (notEmpty(text)) ? null : 'No puede estar vacio',
                ),
                FormFieldData(
                  title: 'Direccion:',
                  initialValue: ClientData.clientAddress ?? '',
                  icon: Icons.location_on,
                  callback: (text) => client.clientAddress = text,
                  validate: (text) => null,
                ),
                FormFieldData(
                  title: 'Ruc:',
                  initialValue: ClientData.clientRuc,
                  icon: Icons.location_on,
                  callback: (text) => client.clientRuc = text,
                  validate: (text) => null,
                ),
                FormFieldData(
                  title: 'DV:',
                  initialValue: ClientData.clientDv,
                  icon: Icons.location_on,
                  callback: (text) => client.clientAddress = text,
                  validate: (text) => null,
                ),
                FormFieldData(
                  title: 'Correo Electronico:',
                  initialValue: ClientData.clientMail,
                  icon: Icons.business,
                  callback: (text) => client.clientMail = text,
                  validate: (text) =>
                      (isEmail(text)) ? null : 'Correo Invalido',
                ),
                FormFieldData(
                  title: 'Cambiar Clave:',
                  initialValue: ClientData.password,
                  icon: Icons.business,
                  callback: (text) => client.password = text,
                  validate: (text) =>
                      (notEmpty(text)) ? null : 'No puede estar vacio',
                  obscureText: true,
                  password: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: _exit(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _exit extends StatelessWidget {
  const _exit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigation = Provider.of<NavigationProvider>(context, listen: false);
    return ElevatedButton(
        onPressed: () {
          final StoreData storeJwt = StoreData();
          storeJwt.deleteAllData();
          navigation.currentIndex = 0;
          Navigator.pushNamed(context, '/login');
        },
        child: Text('Cerrar Sesion'));
  }
}

class _send extends StatefulWidget {
  final Client client;
  final formKey;
  _send({
    Key? key,
    required this.formKey,
    required this.client,
  }) : super(key: key);

  @override
  State<_send> createState() => _sendState();
}

class _sendState extends State<_send> {
  bool _isLoading = false;
  ClientService _clientService = ClientService();

  @override
  Widget build(BuildContext context) {
    var ClientData = Provider.of<ClientNotifier>(context, listen: true);
    return ElevatedButton(
        onPressed: (_isLoading)
            ? null
            : () async {
                if (widget.formKey.currentState.validate()) {
                  setState(() {
                    _isLoading = true;
                  });
                  Client updatedClient = Client.fromJson(
                      await _clientService.updateClient(widget.client));
                  ClientData.updateUser(updatedClient);
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
        child: (_isLoading) ? Text('Actualizando...') : Text('Actualizar'));
  }
}
